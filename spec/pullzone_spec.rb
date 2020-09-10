require "spec_helper"

RSpec.describe BunnyCDN::Pullzone do
  before(:each) do
    BunnyCDN.configure do |config|
      config.apiKey = ENV["API_KEY"]
    end
    headers =
      {
        :content_type => "application/json",
        :accept => "application/json",
        :accesskey => BunnyCDN.configuration.apiKey,
      }
  end

  describe "#getAllPullzones" do
    before do
      stub_request(:get, "https://bunnycdn.com/api/pullzone").
        with(
        headers: {
          :content_type => "application/json",
          :accept => "application/json",
          :accessKey => BunnyCDN.configuration.apiKey,
        },
      ).to_return(status: 200)
    end
    it "gets all pullzones" do
      BunnyCDN::Pullzone.getAllPullzones
      expect(WebMock).to have_requested(:get, "https://bunnycdn.com/api/pullzone").
                           with(headers: {
                                  :content_type => "application/json",
                                  :accept => "application/json",
                                  :accesskey => BunnyCDN.configuration.apiKey,
                                }).once
    end
  end

  describe "#createPullzone" do
    before do
      stub_request(:post, "https://bunnycdn.com/api/pullzone").
        with(
        headers: {
          :content_type => "application/json",
          :accept => "application/json",
          :accessKey => BunnyCDN.configuration.apiKey,
        },
        body: {
          :name => "test",
          :type => 0,
          :originUrl => "http://example.com",
        },
      ).to_return(status: 200)
    end
    it "gets all pullzones" do
      BunnyCDN::Pullzone.createPullzone("test", 0, "http://example.com")
      expect(WebMock).to have_requested(:post, "https://bunnycdn.com/api/pullzone").
          with(
          headers: {
            :content_type => "application/json",
            :accept => "application/json",
            :accessKey => BunnyCDN.configuration.apiKey,
          },
          body: {
            :name => "test",
            :type => 0,
            :originUrl => "http://example.com",
          },
        ).once
    end
  end

  describe "#getSinglePullzone" do
    before do
      stub_request(:get, "https://bunnycdn.com/api/pullzone/1234").
        with(
        headers: {
          :content_type => "application/json",
          :accept => "application/json",
          :accessKey => BunnyCDN.configuration.apiKey,
        },
      ).to_return(status: 200)
    end
    it "gets a single pullzone by ID" do
      BunnyCDN::Pullzone.getSinglePullzone(1234)
      expect(WebMock).to have_requested(:get, "https://bunnycdn.com/api/pullzone/1234").
          with(
          headers: {
            :content_type => "application/json",
            :accept => "application/json",
            :accessKey => BunnyCDN.configuration.apiKey,
          },
        ).once
    end
  end

  describe "#deletePullzone" do
    before do
      stub_request(:delete, "https://bunnycdn.com/api/pullzone/1234").
        with(headers: {
               :content_type => "application/json",
               :accept => "application/json",
               :accessKey => BunnyCDN.configuration.apiKey,
             }).to_return(status: 200)
    end
    it "deletes pullzone by ID" do
      BunnyCDN::Pullzone.deletePullzone(1234)
      expect(WebMock).to have_requested(:delete, "https://bunnycdn.com/api/pullzone/1234").
                           with(headers: {
                                  :content_type => "application/json",
                                  :accept => "application/json",
                                  :accessKey => BunnyCDN.configuration.apiKey,
                                }).once
    end
  end

  describe "#purgeCache" do
    before do
      stub_request(:post, "https://bunnycdn.com/api/pullzone/1234/purgeCache").
        with(headers: {
               :content_type => "application/json",
               :accept => "application/json",
               :accessKey => BunnyCDN.configuration.apiKey,
             }).to_return(status: 200)
    end
    it "purges cache for the specified pullzone" do
      BunnyCDN::Pullzone.purgeCache(1234)
    end
  end
end
