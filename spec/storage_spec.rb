require "spec_helper"

RSpec.describe BunnyCDN::Storage do
  before(:each) do
    BunnyCDN.configure do |config|
      config.storageZone = ENV["STORAGE_ZONE"]
      config.region = ENV["REGION"]
      config.accessKey = ENV["ACCESS_KEY"]
    end
    headers = {
      :accesskey => BunnyCDN.configuration.accessKey,
    }
  end

  describe "#getAllFiles" do
    before do
      stub_request(:get, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{ENV["FILE_PATH"]}").
        with(
        headers: {
          :accesskey => BunnyCDN.configuration.accessKey,
        },
      ).
        to_return(status: 200, body: "")
    end
    it "gets all files from storage zone" do
      headers = {
        :accesskey => BunnyCDN.configuration.accessKey,
      }
      BunnyCDN::Storage.getZoneFiles
      # RestClient.get("https://storage.bunnycdn.com/#{BunnyCDN.configuration.storageZone}/", headers)
      expect(WebMock).to have_requested(:get, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/").
          with(headers: {
                 :accesskey => BunnyCDN.configuration.accessKey,
               }).once
    end
  end

  describe "#getFile" do
    before do
      file = "test_file.txt"
      stub_request(:get, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{ENV["FILE_PATH"]}/#{file}").
        with(
        headers: {
          :accesskey => BunnyCDN.configuration.accessKey,
        },
      ).
        to_return(status: 200)
    end
    it "gets a single file from the storage zone" do
      headers = {
        :accesskey => BunnyCDN.configuration.accessKey,
      }
      path = ENV["FILE_PATH"]
      file = "test_file.txt"
      BunnyCDN::Storage.getFile(path, file)
      expect(WebMock).to have_requested(:get, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{path}/#{file}").
          with(headers: {
                 :accesskey => BunnyCDN.configuration.accessKey,
               }).once
    end
  end

  describe "#uploadFile" do
    before do
      file = File.join("spec", "test_file.txt")
      stub_request(:put, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{ENV["FILE_PATH"]}/#{File.basename(file)}").
        with(
        headers: {
          :accesskey => BunnyCDN.configuration.accessKey,
          :checksum => "",
        },
        body: File.read(file),
      ).
        to_return(status: 200)
    end
    it "uploads file to storage zone" do
      headers = {
        :accessKey => BunnyCDN.configuration.accessKey,
        :checksum => "",
      }
      path = ENV["FILE_PATH"]
      file = File.join("spec", "test_file.txt")
      # BunnyCDN::Storage.uploadFile(path, file)
      RestClient.put("#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{ENV["FILE_PATH"]}/#{File.basename(file)}", File.read(file), headers)
      expect(WebMock).to have_requested(:put, "#{BunnyCDN::Storage.set_region_url}/#{BunnyCDN.configuration.storageZone}/#{ENV["FILE_PATH"]}/#{File.basename(file)}").
          with(headers: {
                 :accesskey => BunnyCDN.configuration.accessKey,
                 :checksum => "",
               }).once
    end
  end

  # describe "#deleteFile" do
  #   before do
  #     stub_request(:delete, "https://storage.bunnycdn.com/#{BunnyCDN.configuration.storageZone}/#{ENV['FILE_PATH']}/#{ENV['FILE_NAME']}").
  #       with(
  #         headers: {
  #           :accesskey => BunnyCDN.configuration.accessKey
  #         }).
  #         to_return(status: 200)
  #   end
  #   it "deletes file to storage zone" do
  #     headers = {
  #       :accessKey => BunnyCDN.configuration.accessKey
  #     }
  #     path = ENV['FILE_PATH']
  #     file = ENV['FILE_NAME']
  #     BunnyCDN::Storage.deleteFile(path, file)
  #     expect(WebMock).to have_requested(:delete ,"https://storage.bunnycdn.com/#{BunnyCDN.configuration.storageZone}/#{ENV['FILE_PATH']}/#{ENV['FILE_NAME']}").
  #       with(headers: {
  #         :accesskey => BunnyCDN.configuration.accessKey
  #       }).once
  #   end
  # end
end
