#! ruby -Ku
# -*- coding: utf-8 -*-
require 'sequel'
require 'logger'
require 'mail'
require 'hashie'

# Path of setting files.
configfile = "config/redmine_ticket_messanger.yml"

# Read to setting files.
if File.exist?(configfile) then
  $init_config = Hashie::Mash.load(configfile)
else
  raise 'HashieLoadError'
end

# Set Database element in variables.
db_addr = $init_config.database.address
db_user = $init_config.database.user_name
db_pass = $init_config.database.password
db_table = $init_config.database.table_name


class MAIL_CTRL
  def send_message(subject, mailbody)
    mail = Mail.new
    options = {
      :address                =>  $init_config.smtp.address,
      :port                   =>  $init_config.smtp.port,
      :domain                 =>  $init_config.smtp.domain,
      :user_name              =>  $init_config.smtp.user_name,
      :password               =>  $init_config.smtp.password,
      :authentication         =>  :login,
      :enable_starttls_auto   =>  true
    }

    mail.charset = $init_config.smtp.charset
    mail.from $init_config.smtp.from
    mail.delivery_method(:smtp, options)

    if(mailbody.empty?) then
      # エラー時のメール処理を書く
      exit 1
    else
      mail.to $init_config.smtp.to
      mail.subject subject
      mail.body mailbody.join
      mail.deliver
    end
  end

  def create_message_template(project_name, subject, assigned_to)
    result = <<-EOS
      ----------------------------------------
      【プロジェクト名】 #{project_name}
      【題名】 #{subject}
      【担当者】 #{assigned_to}
    EOS

    return result
  end

  def update_message_insert(result, header, footer)
    result.unshift(header)
    result.push(footer)

    return result
  end
end

def query_select
  mail = MAIL_CTRL.new()
  mailbody = Array.new()

  # SELECT `subject`, `firstname`, `lastname`, `name` FROM `issues` LEFT OUTER JOIN `users` ON (`users`.`id` = `issues`.`assigned_to_id`) LEFT OUTER JOIN `projects` ON (`projects`.`id` = `issues`.`project_id`) WHERE ((`status_id` = '1') AND (`project_id` = '10'))
  req = Issue.graph(User, :id => :assigned_to_id).graph(Project, {:id => :project_id}, :implicit_qualifier => :issues).where(:status_id=>"1").select(:subject, :firstname, :lastname, :name).all

  req.each{|e|
    msg = mail.create_message_template(e[:name].to_s, e[:subject].to_s, e[:lastname].to_s + e[:firstname].to_s)
    mailbody << msg.gsub!("\n", "\r\n")
  }
  
  cnt = mailbody.count / 4
  mailbody = mail.update_message_insert(mailbody, "Redmineに'"'新規'"'ステータスのチケットが" << cnt.to_s << "件存在します、担当者は処理を開始してください。\r\n\r\n", "----------------------------------------\r\nhttps://redmineops.empathy.jp/")
  mail.send_message("[Warn]Also a new ticket now exists in the Redmine.", mailbody)
end

# Will be connecting on Database.
db_uri = "mysql2://" << db_user << ":" << db_pass << "@" << db_addr << "/" << db_table
begin
  Sequel.connect(db_uri, :loggers => [Logger.new($stdout)])
rescue DBConnectionError => ex
  raise "DBConnectionError"
end

# If these were to connect to started.
class User < Sequel::Model
  one_to_many :issues
end

class Project < Sequel::Model
  one_to_many :issues
end

class Issue < Sequel::Model
  many_to_one :users
  many_to_one :projects
end

query_select()