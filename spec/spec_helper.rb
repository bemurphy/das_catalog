gem "minitest"
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha'
require 'fakefs/safe'
require 'fileutils'
require 'tempfile'
require 'logger'
require 'fakeweb'

require_relative '../lib/das_catalog'

alias :context :describe

null_logger = ::Logger.new("/dev/null")

MiniTest::Spec.add_setup_hook do
  DasCatalog.configure do |c|
    c.tracker_file = Tempfile.new("das_tracker")
    c.logger = null_logger
  end
end

FakeWeb.allow_net_connect = false
