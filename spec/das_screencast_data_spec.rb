require_relative "spec_helper"

describe DasCatalog::ScreencastData do
  let(:link) { "https://www.destroyallsoftware.com/screencasts/catalog/statistics-over-git-repositories" }
  subject { DasCatalog::ScreencastData.new(link) }

  it "creates a download link by appending download to the link" do
    subject.download_link.must_equal("#{link}/download")
  end

  it "assigns a uuid using SecureRandom.uuid" do
    SecureRandom.stubs(:uuid).returns("spec-uuid")
    subject.uuid.must_equal "spec-uuid"
  end

  it "uses the link as the id" do
    subject.id.must_equal link
  end

  it "doesn't report as downloaded if it hasn't been" do
    refute subject.downloaded?
  end

  it "reports as downloaded if downloaded" do
    subject.downloaded
    assert subject.downloaded?
  end

  it "reports as watched if watched" do
    subject.watched
    assert subject.watched?
  end

  it "can be unwatched" do
    subject.unwatched
    refute subject.watched?
  end

  it "saves by passing itself to the tracker" do
    DasCatalog::Store.expects(:store).with(subject)
    subject.save
  end

  describe "getting the screencast data for a given link" do
    it "creates a new screencast data if one doeesn't already exist" do
      skip "needs new_record?"
      scd = DasCatalog::ScreencastData.for_link(link)
      assert scd.new_record?
    end

    it "finds the screencast data if already persisted" do
      DasCatalog::Store.expects(:find).with(link).returns(subject)
      DasCatalog::ScreencastData.for_link(link).must_equal(subject)
    end
  end
end

