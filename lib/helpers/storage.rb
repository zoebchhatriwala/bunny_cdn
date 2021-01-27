module BunnyCDN
  class Storage
    RestClient.log = STDOUT # enables RestClient logging

    def self.storageZone
      BunnyCDN.configuration.storageZone
    end
    # Sets the proper URL based on the region set in configuration
    def self.set_region_url
      case BunnyCDN.configuration.region
      when nil || "eu"
        "https://storage.bunnycdn.com"
      when "ny"
        "https://ny.storage.bunnycdn.com"
      when "sg"
        "https://sg.storage.bunnycdn.com"
      when "la"
        "https://la.storage.bunnycdn.com"
      end
    end

    def self.apiKey
      BunnyCDN.configuration.accessKey
    end

    def self.headers
      {
        :accesskey => apiKey,
      }
    end

    def self.getZoneFiles(path = "")
      begin
        response = RestClient.get("#{set_region_url}/#{storageZone}/#{path}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.getFile(path = "", file)
      begin
        response = RestClient.get("#{set_region_url}/#{storageZone}/#{path}/#{file}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.uploadFile(path = "", file = nil, headers = {})
      # Base headers
      headers[:accessKey] = apiKey
      headers[:checksum] = ""

      # Upload
      begin
        response = RestClient.put("#{set_region_url}/#{storageZone}/#{path}", file, headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end

      return response.body
    end

    def self.deleteFile(path = "")
      # If path is empty it deletes everything; Preventing it.
      if path.present?
        begin
          response = RestClient.delete("#{set_region_url}/#{storageZone}/#{path}", headers)
        rescue RestClient::ExceptionWithResponse => exception
          return exception
        end
        return response.body
      end
    end
  end
end
