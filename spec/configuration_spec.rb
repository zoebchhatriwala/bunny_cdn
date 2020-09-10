require "spec_helper"

RSpec.describe BunnyCDN::Configuration do
  it "has configuration class" do
  end

  describe "#configure" do
    it "has default values of nil" do
      config = BunnyCDN::Configuration.new
      expect(config.storageZone).to eq(nil)
      expect(config.region).to eql(nil)
      expect(config.accessKey).to eq(nil)
    end
  end

  describe "#configure=" do
    it "is able to accept values" do
      config = BunnyCDN::Configuration.new
      config.storageZone = "test"
      config.region = "eu"
      config.accessKey = "test"
      expect(config.storageZone).to eq("test")
      expect(config.region).to eq("eu")
      expect(config.accessKey).to eq("test")
    end
  end

  describe "#configuration" do
    before do
      BunnyCDN.configure do |config|
        config.storageZone = "test"
        config.region = "eu"
        config.accessKey = "test"
      end
    end
    it "can read configuration values" do
      expect(BunnyCDN.configuration.storageZone).to eq("test")
      expect(BunnyCDN.configuration.region).to eq("eu")
      expect(BunnyCDN.configuration.accessKey).to eq("test")
    end
  end
end
