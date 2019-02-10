module MetMuseum
  class Collection
    MetMuseumError = Class.new(StandardError)
    BadRequestError = Class.new(MetMuseumError)
    UnauthorizedError = Class.new(MetMuseumError)
    ForbiddenError = Class.new(MetMuseumError)
    ApiRequestsQuotaReachedError = Class.new(MetMuseumError)
    NotFoundError = Class.new(MetMuseumError)
    UnprocessableEntityError = Class.new(MetMuseumError)
    ApiError = Class.new(MetMuseumError)

    API_ENDPOINT = "https://collectionapi.metmuseum.org".freeze
    PUBLIC_URI = "/public/collection/v1/objects".freeze
    SEARCH_URI = "/public/collection/v1/search".freeze

    HTTP_OK_CODE = 200.freeze

    HTTP_BAD_REQUEST_CODE = 400.freeze
    HTTP_UNAUTHORIZED_CODE = 401.freeze
    HTTP_FORBIDDEN_CODE = 403.freeze
    HTTP_NOT_FOUND_CODE = 404.freeze
    HTTP_UNPROCESSABLE_ENTITY_CODE = 429.freeze


    # Return a listing of all valid Object IDs available to use
    # @param [String] metadataDate Returns any objects with updated data after this date
    # @return [Hash<total, Integer>] The total number of publicly-available objects
    # @return [Hash<objectIDs, Array<Integer>>] An array containing the object ID of publicly-available object
    def objects(metadataDate = nil)
      conn = Faraday.new(:url => API_ENDPOINT)
      response = conn.get PUBLIC_URI, {:metadataDate => metadataDate}
      Oj.load(response.body) if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"
    end

    # returns a record for an object, containing all open access data about that object, including its image (if the image is available under Open Access)
    # @param [Integer] objectID The unique Object ID for an object
    # @return [Hash<objectID, Integer>] Identifying number for each artwork (unique, can be used as key field)
    # @return [Hash<isHighlight, Boolean>] When "true" indicates a popular and important artwork in the collection
    # @return [Hash<accessionNumber, String>] Identifying number for each artwork (not always unique)
    # @return [Hash<isPublicDomain, Boolean>] When "true" indicates an artwork in the Public Domain
    # @return [Hash<primaryImage, String>] URL to the primary image of an object in JPEG format
    # @return [Hash<primaryImageSmall, String>] URL to the lower-res primary image of an object in JPEG format
    # @return [Hash<additionalImages, Array<String>>] An array containing URLs to the additional images of an object in JPEG format
    # @return [Hash<constituents, Array<Hash<String:String>>>] An array containing the constituents of an object, with both an artist name and their role
    # @return [Hash<department, String>] Indicates The Met's curatorial department responsible for the artwork
    # @return [Hash<objectName, String>] Describes the physical type of the object
    # @return [Hash<title, String>] Title, identifying phrase, or name given to a work of art
    # @return [Hash<culture, String>] 	Information about the culture, or people from which an object was created
    # @return [Hash<period, String>] Time or time period when an object was created
    # @return [Hash<dynasty, String>] Dynasty (a succession of rulers of the same line or family) under which an object was created
    # @return [Hash<reign, String>] Reign of a monarch or ruler under which an object was created
    # @return [Hash<portfolio, String>] A set of works created as a group or published as a series.
    # @return [Hash<artistRole, String>] 	Role of the artist related to the type of artwork or object that was created
    # @return [Hash<artistPrefix, String>] TDescribes the extent of creation or describes an attribution qualifier to the information given in the artistRole field
    # @return [Hash<artistDisplayName, String>] Artist name in the correct order for display
    # @return [Hash<artistDisplayBio, String>] Nationality and life dates of an artist, also includes birth and death city when known
    # @return [Hash<artistSuffix, String>] Used to record complex information that qualifies the role of a constituent, e.g. extent of participation by the Constituent (verso only, and followers)
    # @return [Hash<artistAlphaSort, String>] Used to sort artist names alphabetically. Last Name, First Name, Middle Name, Suffix, and Honorific fields, in that order.
    # @return [Hash<artistNationality, String>] National, geopolitical, cultural, or ethnic origins or affiliation of the creator or institution that made the artwork
    # @return [Hash<artistBeginDate, String>] Year the artist was born
    # @return [Hash<artistEndDate, String>] Year the artist died
    # @return [Hash<objectDate, string>] The total number of publicly-available objects
    # @return [Hash<total, string>] Year, a span of years, or a phrase that describes the specific or approximate date when an artwork was designed or created
    # @return [Hash<objectBeginDate, string>] Machine readable date indicating the year the artwork was started to be created
    # @return [Hash<objectEndDate, string>] Machine readable date indicating the year the artwork was completed (may be the same year or different year than the objectBeginDate)
    # @return [Hash<medium, string>] Refers to the materials that were used to create the artwork
    # @return [Hash<dimensions, string>] Size of the artwork or object
    # @return [Hash<creditLine, String>] 	Text acknowledging the source or origin of the artwork and the year the object was acquired by the museum.
    # @return [Hash<geographyType, String>] 	Qualifying information that describes the relationship of the place catalogued in the geography fields to the object that is being catalogued
    # @return [Hash<city, String>] City where the artwork was created
    # @return [Hash<state, String>] State or province where the artwork was created, may sometimes overlap with County
    # @return [Hash<county, String>] County where the artwork was created, may sometimes overlap with State
    # @return [Hash<country, String>] Country where the artwork was created or found
    # @return [Hash<region, String>] Geographic location more specific than country, but more specific than subregion, where the artwork was created or found (frequently null)
    # @return [Hash<subregion, String>] Geographic location more specific than Region, but less specific than Locale, where the artwork was created or found (frequently null)
    # @return [Hash<locale, String>] Geographic location more specific than subregion, but more specific than locus, where the artwork was found (frequently null)
    # @return [Hash<locus, String>] Geographic location that is less specific than locale, but more specific than excavation, where the artwork was found (frequently null)
    # @return [Hash<excavation, String>] The name of an excavation. The excavation field usually includes dates of excavation.
    # @return [Hash<river, String>] River is a natural watercourse, usually freshwater, flowing toward an ocean, a lake, a sea or another river related to the origins of an artwork (frequently null)
    # @return [Hash<classification, String>] General term describing the artwork type.
    # @return [Hash<rightsAndReproduction, String>] Credit line for artworks still under copyright.
    # @return [Hash<linkResource, String>] URL to object's page on metmuseum.org
    # @return [Hash<metadataDate, String>] Date metadata was last updated
    # @return [Hash<repository, String>]
    # @return [Hash<objectURL, String>] URL to object's page on metmuseum.org
    # @return [Hash<tags,  Array<String>>] An array of subject keyword tags associated with the object
    def object(objectID)
      response = Faraday.get "#{API_ENDPOINT}#{PUBLIC_URI}/#{objectID}"
      Oj.load(response.body)if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"
    end

    def search(q)
      conn = Faraday.new(:url => API_ENDPOINT)
      response = conn.get SEARCH_URI, {:q => q}
      Oj.load(response.body)if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"

    end

    def error_class(response)
      case response.status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        return ApiRequestsQuotaReachedError if api_requests_quota_reached?
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      else
        ApiError
      end
    end

    def response_successful?(response)
      response.status == HTTP_OK_CODE
    end
  end
end
