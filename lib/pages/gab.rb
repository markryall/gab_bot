module Pages
  module Gab
    def goto
      browser.goto 'gab.thoughtworks.com'
    end

    def search text
      browser.text_field(id: 'gab_search_box').set text
      browser.button(value: 'Search ').click
    end

    def information
      row = browser.tables[2][1]
      (0..5).map {|n| row[n].text}
    end
  end
end
