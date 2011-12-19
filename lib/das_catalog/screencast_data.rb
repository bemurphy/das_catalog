require 'securerandom'

module DasCatalog
  class ScreencastData
    attr_reader :link, :watched, :uuid

    def initialize(link)
      @link = link
      initialize_uuid
    end

    def initialize_uuid
      @uuid ||= SecureRandom.uuid
    end

    def self.for_link(link)
      Store.find(link) or new(link)
    end

    alias :id :link

    def download_link
      "#{link}/download"
    end

    def downloaded
      @downloaded = true
    end

    def reset_downloaded
      @downloaded = false
    end

    def downloaded?
      @downloaded
    end

    def watched
      @watched = true
    end

    def reset_watched
      @watched = false
    end

    def watched?
      @watched
    end

    def save
      Store.store(self)
    end
  end
end
