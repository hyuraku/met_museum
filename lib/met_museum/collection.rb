module MetMuseum
  class Collection
    API_ENDPOINT = "https://collectionapi.metmuseum.org".freeze
    PUBLIC_URI = "/public/collection/v1/objects".freeze

    # Return a listing of all valid Object IDs available to use
    # @param [String] metadataDate Returns any objects with updated data after this date
    # @return [Hash<total, Integer>] The total number of publicly-available objects
    # @return [Hash<objectIDs, Array<Integer>>] An array containing the object ID of publicly-available object
    def self.objects(metadataDate = nil)
      conn = Faraday.new(:url => API_ENDPOINT)
      response = conn.get PUBLIC_URI, {:metadataDate => metadataDate}
      Oj.load(response.body)
    end

    # returns a record for an object, containing all open access data about that object, including its image (if the image is available under Open Access)
    # @param [Integer] objectID The unique Object ID for an object
    def self.object(objectID)
      response = Faraday.get "#{API_ENDPOINT}#{PUBLIC_URI}/#{objectID}"
      Oj.load(response.body)
    end
  end
end
