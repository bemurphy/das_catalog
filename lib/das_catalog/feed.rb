require 'rss/1.0'
require 'rss/2.0'

module DasCatalog
  class Feed
    FEED_URL = "https://www.destroyallsoftware.com/screencasts/feed"

    def self.get
      content = ""
      open(FEED_URL) do |s|
        content = s.read
      end
      RSS::Parser.parse(content,false)
    end
  end
end
