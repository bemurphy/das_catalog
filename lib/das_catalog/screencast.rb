module DasCatalog
  class Screencast
    extend Forwardable
    include LoggerAccess

    attr_reader :screencast_data
    def_delegators :@screencast_data, :watched?, :downloaded?, :download_link

    def initialize(screencast_data)
      @screencast_data = screencast_data
    end

    def self.for_link(link)
      new ScreencastData.for_link(link)
    end

    def to_s
      screencast_data.link
    end

    def download
      return false if screencast_data.downloaded?
      log.info "Starting download of #{self}"
      Downloader.process(self)
      screencast_data.downloaded
      log.info "Finished download of #{self}"
      screencast_data.save
    end
  end
end
