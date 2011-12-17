require_relative "spec_helper"

describe DasCatalog::Screencast do
  let(:link) { "https://www.destroyallsoftware.com/screencasts/catalog/statistics-over-git-repositories" }
  let(:screencast_data) { sd = mock("ScreencastData"); sd.stubs(:link).returns(link); sd }
  subject { DasCatalog::Screencast.new(screencast_data) }

  it "is created from screencast data" do
    screencast = DasCatalog::Screencast.new(screencast_data)
    screencast.screencast_data.must_equal(screencast_data)
  end

  it "contains screencast data" do
    assert subject.screencast_data
  end

  it "is converting to a string that is the link" do
    subject.to_s.must_equal link
  end

  it "can be created for a given link" do
    screencast_data = mock()
    DasCatalog::ScreencastData.expects(:for_link).with(link).returns(screencast_data)
    DasCatalog::Screencast.for_link(link).screencast_data.must_equal screencast_data
  end

  it "delegates to the screencast data for watched?" do
    screencast_data.stubs(:watched?).returns(false, true)
    refute subject.watched?
    assert subject.watched?
  end

  it "delegates to the screencast data for downloaded?" do
    screencast_data.stubs(:downloaded?).returns(false, true)
    refute subject.downloaded?
    assert subject.downloaded?
  end

  it "delegates to the screencast data for download link" do
    screencast_data.stubs(:download_link).returns("http://example.com/path")
    subject.download_link.must_equal "http://example.com/path"
  end

  describe "downloading" do
    before do
      DasCatalog::Downloader.stubs(:process)
      screencast_data.stubs(:save)
      screencast_data.stubs(:downloaded?)
      screencast_data.stubs(:downloaded)
    end

    context "for a screencast that hasn't been downloaded" do
      it "occurs by sending itself to the downloader for processing" do
        DasCatalog::Downloader.expects(:process).with(subject)
        subject.download
      end

      it "marks the screencast data downloaded" do
        screencast_data.expects(:downloaded)
        subject.download
      end

      it "saves the screencast data" do
        screencast_data.expects(:save)
        subject.download
      end
    end

    context "for a screencast that hasn't been downloaded" do
      it "returns false" do
        screencast_data.expects(:downloaded?).returns(true)
        refute subject.download
      end
    end
  end
end

