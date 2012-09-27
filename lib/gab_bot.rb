require 'cinch'
require 'ripl_watir'

module GabBot
  include RiplWatir::Commands

  def execute *args
    RiplWatir.create
    visit_page(:gab)
    Cinch::Bot.new do
        configure do |c|
        c.nick = args.shift
        c.server = args.shift
        c.port = args.shift.to_i
        c.channels = args
      end

      on :message, /^tell me about (.+)$/ do |m, text|
        visit_page(:gab).search text
        name, email, work_phone, mobile_phone, aliases, gtalk = on_page(:gab).information
        if name
          m.reply "contact details for #{name} (#{email}):"
          m.reply "work phone is #{work_phone}" unless work_phone.strip.empty?
          m.reply "mobile phone is #{mobile_phone}" unless mobile_phone.empty?
        else
          m.reply "couldn't find a phone number for #{text} sorry"
        end
      end
    end.start
  end
end
