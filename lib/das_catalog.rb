require 'feedzirra'
require 'mechanize'
require 'shellwords'
require 'uri'
require 'pstore'
require 'forwardable'

module DasCatalog
  SIGN_IN_URL = "https://www.destroyallsoftware.com/screencasts/users/sign_in"

  # TODO spec this
  class << self
    attr_accessor :username
    attr_accessor :password
    attr_accessor :downloads_directory

    attr_writer :logger
    def logger
      @logger ||= StdLogger.new
    end

    attr_writer :tracker_file
    def tracker_file
      @tracker_file ||= File.expand_path("~/.das_tracker.pstore")
    end
  end

  def self.configure
    yield self
  end

  # TODO spec this
  def self.agent
    @agent ||= begin
      agent = Mechanize.new
      page = agent.get SIGN_IN_URL
      form = page.forms.first
      form['user[email]'] = username
      form['user[password]'] = password
      agent.submit form
      agent
    end
  end

  # TODO spec this
  def self.sync
    feed = Feed.get
    feed.entries.each do |entry|
      sc = Screencast.for_link(entry.url)
      sc.download
    end
  end
end

require_relative "das_catalog/downloader"
require_relative "das_catalog/feed"
require_relative "das_catalog/std_logger"
require_relative "das_catalog/screencast"
require_relative "das_catalog/screencast_data"
require_relative "das_catalog/store"
