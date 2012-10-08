require 'cinch'
require 'ripl_watir'
require 'highline/import'

module GabBot
  include RiplWatir::Commands

  def execute *args
    RiplWatir.create
    visit_page(:gab)
    username = ask 'username > '
    password = ask 'password > '
    on_page(:gab).login username, password
    nick, server, port, *channels = *args
    Cinch::Bot.new do
      configure do |c|
        c.nick = nick
        c.server = server
        c.port = port.to_i
        c.channels = channels
      end

      on(:message, /^#{nick} help$/) do |m|
        m.reply "usage: #{nick} search <criteria> - search gab for contact information"
        m.reply "code:  https://github.com/markryall/gab_bot"
      end

      on :message, /^#{nick} search (.+)$/ do |m, text|
        visit_page(:gab).search text
        begin
          name, email, work_phone, mobile_phone, aliases, gtalk = on_page(:gab).information
          m.reply "contact details for #{name} (#{email}):"
          m.reply "work phone is #{work_phone}" unless work_phone.strip.empty?
          m.reply "mobile phone is #{mobile_phone}" unless mobile_phone.empty?
        rescue Watir::Exception::UnknownObjectException
          m.reply "couldn't find details for \"#{text}\" sorry"
        end
      end
    end.start
  end
end
