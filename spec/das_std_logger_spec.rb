require_relative "spec_helper"

describe DasCatalog::StdLogger do
  it "creates a standard ruby logger to STDOUT" do
    ::Logger.expects(:new).with(STDOUT)
    DasCatalog::StdLogger.new
  end

  [:fatal, :error, :warn, :info, :debug].each do |log_method|
    it "delegates #{log_method} to the contained logger" do
      logger = DasCatalog::StdLogger.new
      assert_respond_to(logger, log_method)
      
    end
  end

  describe "the logger mixin" do
    let(:klass) { Class.new }

    before do
      DasCatalog.logger = mock("Logger")
      klass.send(:include, DasCatalog::LoggerAccess)
    end

    it "adds a log class method to grab the DasCatalog.logger" do
      assert klass.respond_to?(:log)
      klass.log.must_equal(DasCatalog.logger)
    end

    it "also adds a log instance method" do
      assert klass.new.respond_to?(:log)
      klass.log.must_equal(DasCatalog.logger)
    end
  end
end
