#! ruby -Ku
# -*- coding: utf-8 -*-
require 'sequel'
require 'logger'
require 'mail'

# Set Database element in variables.
db_addr = "127.0.0.1"
db_user = "root"
db_pass = "user"
db_table = "pass"


class MAIL_CTRL
  def send_message(msg)
    mail = Mail.new
    options = {
      :address                =>  "example.com",
      :port                   =>  587,
      :domain                 =>  "smtp.example.com",
      :user_name              =>  "userfrom@example.com",
      :password               =>  "password",
      :authentication         =>  :login,
      :enable_starttls_auto   =>  true
    }

    mail.charset = 'UTF-8'
    mail.from "userfrom@example.com"
    mail.delivery_method(:smtp, options)

    if(msg.empty?) then
      # エラー時のメール処理を書く
      exit 1
    else
      mail.to "userto@example.com"
      mail.subject "[Warn]Also a new ticket now exists in the Redmine."
      mail.body msg.join
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

  def update_message_insert(result)
    cnt = result.count / 4
    header = "Redmineに'"'新規'"'ステータスのチケットが" << cnt.to_s << "件存在します、担当者は処理を開始してください。\r\n\r\n"
    footer = "----------------------------------------\r\nhttps://redmine.example.com/"
    result.unshift(header)
    result.push(footer)

    return result
  end
end

def query_select
  mail = MAIL_CTRL.new()
  result = Array.new()

  # SELECT `subject`, `firstname`, `lastname`, `name` FROM `issues` LEFT OUTER JOIN `users` ON (`users`.`id` = `issues`.`assigned_to_id`) LEFT OUTER JOIN `projects` ON (`projects`.`id` = `issues`.`project_id`) WHERE ((`status_id` = '1') AND (`project_id` = '10'))
  req = Issue.graph(User, :id => :assigned_to_id).graph(Project, {:id => :project_id}, :implicit_qualifier => :issues).where(:status_id=>"1").select(:subject, :firstname, :lastname, :name).all

  req.each{|e|
    msg = mail.create_message_template(e[:name].to_s, e[:subject].to_s, e[:lastname].to_s + e[:firstname].to_s)
    result << msg.gsub!("\n", "\r\n")
  }
  
  result = mail.update_message_insert(result)
  mail.send_message(result)
end

# Will be connecting on Database.
db_uri = "mysql2://" << db_user << ":" << db_pass << "@" << db_addr << "/" << db_table
begin
  Sequel.connect(db_uri, :loggers => [Logger.new($stdout)])
rescue DBConnectionError => ex
  puts "DBConnectionError"
  raise
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