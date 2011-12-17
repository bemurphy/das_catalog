require_relative "spec_helper"

describe DasCatalog do
  it "has a DasCatalog::StdLogger by default" do
    assert DasCatalog.logger
  end
end
