require "met_museum/endpoint"
require "met_museum/http_status_code"
require "json"

module MetMuseum
  class Collection
    # Returns a listing of all valid Object IDs available to use based on the given parameters.
    # @param [Date, DateTime] metadataDate Returns objects with updated data after this date.
    # @param [Integer] departmentIds Returns objects in a specific department.
    # @return [Hash<Symbol, Object>] A hash containing two keys:
    #   - :total (Integer): The total number of publicly-available objects.
    #   - :objectIDs (Array<Integer>): An array containing the object ID of publicly-available objects.
    def objects(**args)
      options = {
        metadataDate: nil,
        departmentIds: nil
      }.merge(args)

      options[:metadataDate] = check_date(options[:metadataDate])
      query = { metadataDate: options[:metadataDate], departmentIds: options[:departmentIds] }
      response = create_request(API_ENDPOINT, PUBLIC_URI, query)
      arrange_response(response)
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
    # @return [Hash<dimensionsParsed, Array<Hash>>] 	Size of the artwork or object in centimeters, parsed
    # @return [Hash<measurements, Array<Hash>>] 	Array of elements, each with a name, description, and set of measurements. Spatial measurements are in centimeters; weights are in kg.
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
    # @return [Hash<objectWikidata_URL, string>] Wikidata URL for the object
    # @return [Hash<isTimelineWork, boolean>] Whether the object is on the Timeline of Art History website
    # @return [Hash<GalleryNumber, string>] Gallery number, where available

    def object(object_id)
      response = create_request(API_ENDPOINT, "#{PUBLIC_URI}/#{object_id}")
      arrange_response(response)
    end

    # returns a listing of all departments
    # @return [Array] departments An array containing the JSON objects that contain each department's departmentId and display name. The departmentId is to be used as a query parameter on the `/objects` endpoint
    # @return [Integer] departments Department ID as an integer. The departmentId is to be used as a query parameter on the `/objects` endpoint
    # @return [String] departments Display name for a department
    def department
      response = create_request(API_ENDPOINT, DEPARTMENTS_URI)
      arrange_response(response)
    end

    # Retrieves a list of all Object IDs for objects that contain the given search term within the object’s data
    # @param [String] query The search term to look for (e.g. "sunflowers")
    # @param [Integer] limit The maximum number of objects to return
    # @param [Boolean] include_highlights If true, returns objects that match the query and are designated as highlights. Highlights are selected works of art from The Met Museum’s permanent collection representing different cultures and time periods.
    # @return [Integer] total The total number of publicly-available objects that match the search term
    # @return [Array<Integer>] objectIDs An array containing the object ID of each publicly-available object that matches the search term
    # @return [Array<Object>] objects An array containing the objects that contain the search term within the object’s data
    def search(query, **args)
      args.merge!({q: query})
      response = create_request(API_ENDPOINT, SEARCH_URI, args)
      origin_response = arrange_response(response)
      limit = args[:limit].to_i
      return origin_response if limit <= 0

      origin_response["objectIDs"].lazy.map { |id| MetMuseum::Collection.new.object(id) }.first(limit)
    end

    private

    require 'uri'
    require 'net/http'

    def create_request(url, dir, params = {})
      uri = URI.join(url, dir)
      uri.query = URI.encode_www_form(params)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Get.new(uri.request_uri)
      http.request(request)
    end

    def response_successful?(response_code)
      response_code == HTTP_OK_CODE
    end

    def check_date(date)
      case date
      when nil
        nil
      when Date
        date.to_date.to_s
      else
        raise TypeError, "Please provide a valid date"
      end
    end

    def arrange_response(response)
      response_code = response.code.to_i
      unless response_successful?(response_code)
        raise MetMuseum.error_class(response_code), "Code: #{response_code}, response: #{response.body}"
      end
      JSON.parse(response.body)
    end

    def multi_option
      case self
      when String
        return self
      when Array
        return join("|")
      else
        raise TypeError, "Write String or Array type"
      end
    end
  end
end
