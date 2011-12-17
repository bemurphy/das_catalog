require_relative "spec_helper"

describe DasCatalog::Feed do
  it "grabs the feed with feedzirra" do
    Feedzirra::Feed.expects(:fetch_and_parse).with("https://www.destroyallsoftware.com/screencasts/feed")
    DasCatalog::Feed.get
  end
end
