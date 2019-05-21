require "met_museum/api_expections"
require "met_museum/endpoint"
require "met_museum/http_status_code"

module MetMuseum
  class Collection
    # Return a listing of all valid Object IDs available to use
    # @param [Date] metadataDate Returns any objects with updated data after this date
    # @params [Integer] departmentIds Returns any objects in a specific department
    # @return [Hash<total, Integer>] The total number of publicly-available objects
    # @return [Hash<objectIDs, Array<Integer>>] An array containing the object ID of publicly-available object
    def objects(metadataDate = nil, departmentIds = nil)
      metadataDate = check_date(metadataDate) unless metadataDate.nil?
      response = Faraday.new(:url => API_ENDPOINT).get PUBLIC_URI, {:metadataDate => metadataDate, :departmentIds => departmentIds}
      return_response(response)
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
      return_response(response)
    end

    # returns a listing of all departments
    # @return [Array] departments An array containing the JSON objects that contain each department's departmentId and display name. The departmentId is to be used as a query parameter on the `/objects` endpoint
    # @return [Integer] departments Department ID as an integer. The departmentId is to be used as a query parameter on the `/objects` endpoint
    # @return [String] departments Display name for a department
    def department
      response = Faraday.get "#{API_ENDPOINT}#{DEPARTMENTS_URI}"
      return_response(response)
    end

    # returns a listing of all Object IDs for objects that contain the search query within the object’s data
    # @param [String] query search term e.g. sunflowers
    # @param [Interger] limit number of objects zthat contain the search query within the object’s data
    # @return [Integer] total The total number of publicly-available objects
    # @return [Array<Integer>] objectIDs An array containing the object ID of publicly-available object
    # @return [Array<Object>] objects An array containing the objects that contain the search query within the object’s data
    def search(query, limit = 0)
      response = Faraday.new(:url => API_ENDPOINT).get SEARCH_URI, {:q => query}
      origin_response = return_response(response)
      return origin_response if limit <= 0
      origin_response["objectIDs"][0..limit - 1].map{|id| object(id)}
    end

    private

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

    def check_date(date)
      return date.to_s if date.class == Date
    
      raise TypeError, "Write certain date"
    end

    def return_response(response)
      return Oj.load(response.body) if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"
    end
  end
end
