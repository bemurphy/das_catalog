require_relative "spec_helper"

describe DasCatalog::Store do
  let(:link) { "https://www.destroyallsoftware.com/screencasts/catalog/statistics-over-git-repositories" }
  let(:id) { link }
  let(:screencast_data) { scd = mock(); scd.stubs(:id).returns(id); scd }

  it "tracks in the file specified in config" do
    DasCatalog::Store.store(screencast_data)
    assert File.exists?(DasCatalog.tracker_file.path)
  end

  it "can find the screencast by the id" do
    DasCatalog::Store.store(screencast_data)
    assert DasCatalog::Store.find(id)
  end

  it "is nil if the screencast is not found" do
    refute DasCatalog::Store.find(id)
  end
end
