#! ruby -Ku

require 'hashie'
require 'shellwords'

# 設定ファイルパス
configfile = "config/config.yml"

def getMailSettings(mailserver)
	result = Array.new

	if mailserver == "gmail" then
		@init_config.command.mail_default.gmail.each_value do |val|
			result.push(val)
		end
	elsif mailserver == "office365" then
		@init_config.command.mail_default.office365.each_value do |val|
			result.push(val)
		end
	else
		raise 'error'
	end

	return result
end

def getBaseSettings(project)
	result = Array.new

	result.push("project=" + project.name)
	result.push("username=" + project.username)
	result.push("password=" + project.password)

	return result
end

# 設定ファイル読み込み
if File.exist?(configfile) then
	@init_config = Hashie::Mash.load(configfile)
else
	raise 'error'
end

# メイン
@init_config.command.project.each_value do |val|
	# メールのデフォルト設定読み込み
	mail_default = Array.new
	mail_default = getMailSettings(val.mailserver.to_s)
	# プロジェクト毎の設定読み込み
	setting_default = Array.new
	setting_default = getBaseSettings(val)
	# 設定を一つの配列として連結
	setting_default = setting_default + mail_default

	# オプションの文字列結合
	options = @init_config.command.allow_override.join(",")

	cmd = @init_config.command.rake.to_s + " " + setting_default.join(" ") + " " + options

	system("sudo " + cmd)
end

