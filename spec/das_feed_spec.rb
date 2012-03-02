require_relative "spec_helper"

describe DasCatalog::Feed do
  let(:feed) { File.readlines(File.join(File.dirname(__FILE__), "fixtures/feed.xml")).to_s }

  before do
    FakeWeb.register_uri(:get, "https://www.destroyallsoftware.com/screencasts/feed", :body => feed)
  end
  
  it "grabs the feed with open" do
    # This is from openuri but I feel dirty setting mocks on high level objects
    DasCatalog::Feed.expects(:open).with("https://www.destroyallsoftware.com/screencasts/feed")
    DasCatalog::Feed.get
  end

  it "parses the feed with RSS::Parser" do
    RSS::Parser.expects(:parse).with(feed, false)
    DasCatalog::Feed.get
  end
end
