require 'feedzirra'

module DasCatalog
  class Feed
    FEED_URL = "https://www.destroyallsoftware.com/screencasts/feed"

    def self.get
      Feedzirra::Feed.fetch_and_parse(FEED_URL)
    end
  end
end
