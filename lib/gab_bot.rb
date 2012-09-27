require 'cinch'
require 'ripl_watir'

module GabBot
  include RiplWatir::Commands

  def execute *args
    RiplWatir.create
    visit_page(:gab)
    print "Please authenticate with securid then hit enter\n> "
    $stdin.gets
    Cinch::Bot.new do
      configure do |c|
        c.nick = args.shift
        c.server = args.shift
        c.port = args.shift.to_i
        c.channels = args
      end

      on :message, /^gab (.+)$/ do |m, text|
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
