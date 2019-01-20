module MetMuseum
  class Collection
    API_ENDPOINT = "https://collectionapi.metmuseum.org".freeze
    PUBLIC_URI = "/public/collection/v1/objects".freeze

    def self.objects(metadataDate = nil)
      conn = Faraday.new(:url => API_ENDPOINT)
      response = conn.get PUBLIC_URI, {:metadataDate => metadataDate}
      Oj.load(response.body)
    end

    def self.object(objectID)
      response = Faraday.get "#{API_ENDPOINT}#{PUBLIC_URI}/#{objectID}"
      Oj.load(response.body)
    end
  end
end
