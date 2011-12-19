require_relative "spec_helper"

require 'securerandom'

describe DasCatalog::Store do
  let(:link) { "https://www.destroyallsoftware.com/screencasts/catalog/statistics-over-git-repositories" }
  let(:id) { link }
  let(:screencast_data) do
    scd = mock();
    scd.stubs(:id).returns(id);
    scd.stubs(:uuid).returns(SecureRandom.uuid)
    scd
  end

  after do
    DasCatalog::Store.reset
  end

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

  it "can reset the store to be empty" do
    DasCatalog::Store.store(screencast_data)
    assert DasCatalog::Store.find(screencast_data.id)
    DasCatalog::Store.reset
    refute DasCatalog::Store.find(screencast_data.id)
  end

  it "raises an exeption trying to store screencast data if one exists with a different uuid" do
    DasCatalog::Store.store(screencast_data)
    screencast_data.stubs(:uuid).returns(SecureRandom.uuid)
    proc {
      DasCatalog::Store.store(screencast_data)
    }.must_raise(DasCatalog::Store::UUIDMismatch)
  end
end
