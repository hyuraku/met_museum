RSpec.describe MetMuseum do
  describe "Collection" do
    describe "objects" do
      let(:objects) { MetMuseum::Collection.new.objects({ metadataDate: metadataDate, departmentIds: departmentIds }) }
      context "all data" do
        let(:metadataDate) { nil }
        let(:departmentIds) { nil }
        it "success" do
          expect(objects["objectIDs"]).to be_truthy
          expect(objects["total"]).to be_truthy
          expect(objects["objectIDs"].size).to eq objects["total"]
        end
      end

      context "assign metadataDate" do
        context "Date" do
          let(:metadataDate) { Date.new(2018, 10, 10) }
          let(:departmentIds) { nil }
          it "success with DataType metadataDate" do
            expect(objects["objectIDs"]).to be_truthy
            expect(objects["total"]).to be_truthy
            expect(objects["objectIDs"].size).to eq objects["total"]
          end
        end

        context "Datetime" do
          let(:metadataDate) { DateTime.new(2018, 10, 10) }
          let(:departmentIds) { nil }
          it "success with DataType metadataDate" do
            expect(objects["objectIDs"]).to be_truthy
            expect(objects["total"]).to be_truthy
            expect(objects["objectIDs"].size).to eq objects["total"]
          end
        end
      end

      context "assign departmentIds" do
        context "Date" do
          let(:metadataDate) { nil }
          let(:departmentIds) { 11_111 }
          it "success with DataType metadataDate" do
            expect(objects["objectIDs"]).to be_truthy
            expect(objects["total"]).to be_truthy
            expect(objects["objectIDs"].size).to eq objects["total"]
          end
        end
      end
    end

    describe "object" do
      let(:object) { MetMuseum::Collection.new.object(objectID) }
      context "Real objectID" do
        let(:objectID) { 436_535 }
        it "success with objectID" do
          expect(object["objectID"]).to eq(objectID)
          expect(object["isHighlight"]).to eq(true)
          expect(object["accessionNumber"]).to eq("1993.132")
          expect(object["isPublicDomain"]).to eq(true)
          expect(object["primaryImage"]).to eq("https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg")
          expect(object["primaryImageSmall"]).to eq("https://images.metmuseum.org/CRDImages/ep/web-large/DT1567.jpg")
          expect(object["additionalImages"]).to eq [
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-004.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-003.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-002.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-001.jpg"
          ]
          expect(object["constituents"]).to eq([
                                                 {
                                                   "constituentID"=>161947,
                                                   "constituentULAN_URL" => "http://vocab.getty.edu/page/ulan/500115588",
                                                   "constituentWikidata_URL" => "https://www.wikidata.org/wiki/Q5582",
                                                   "gender" => "",
                                                   "name" => "Vincent van Gogh",
                                                   "role" => "Artist"
                                                 }
                                               ])
          expect(object["department"]).to eq("European Paintings")
          expect(object["objectName"]).to eq("Painting")
          expect(object["title"]).to eq("Wheat Field with Cypresses")
          expect(object["culture"]).to eq("")
          expect(object["period"]).to eq("")
          expect(object["dynasty"]).to eq("")
          expect(object["reign"]).to eq("")
          expect(object["portfolio"]).to eq("")
          expect(object["artistRole"]).to eq("Artist")
          expect(object["artistPrefix"]).to eq("")
          expect(object["artistDisplayName"]).to eq("Vincent van Gogh")
          expect(object["artistDisplayBio"]).to eq("Dutch, Zundert 1853–1890 Auvers-sur-Oise")
          expect(object["artistSuffix"]).to eq("")
          expect(object["artistAlphaSort"]).to eq("Gogh, Vincent van")
          expect(object["artistNationality"]).to eq("Dutch")
          expect(object["artistBeginDate"]).to eq("1853")
          expect(object["artistEndDate"]).to eq("1890")
          expect(object["objectDate"]).to eq("1889")
          expect(object["objectBeginDate"]).to eq(1889)
          expect(object["objectEndDate"]).to eq(1889)
          expect(object["medium"]).to eq("Oil on canvas")
          expect(object["dimensions"]).to eq("28 7/8 × 36 3/4 in. (73.2 × 93.4 cm)")
          expect(object["dimensionsParsed"]).to eq(nil)
          expect(object["measurements"]).to eq([{ "elementDescription"=>nil,
                                                  "elementMeasurements"=>{"Height"=>73.34264, "Width"=>93.4}, 
                                                  "elementName"=>"Overall"}])
          expect(object["creditLine"]).to eq("Purchase, The Annenberg Foundation Gift, 1993")
          expect(object["geographyType"]).to eq("")
          expect(object["city"]).to eq("")
          expect(object["state"]).to eq("")
          expect(object["county"]).to eq("")
          expect(object["country"]).to eq("")
          expect(object["region"]).to eq("")
          expect(object["subregion"]).to eq("")
          expect(object["locale"]).to eq("")
          expect(object["locus"]).to eq("")
          expect(object["excavation"]).to eq("")
          expect(object["river"]).to eq("")
          expect(object["classification"]).to eq("Paintings")
          expect(object["rightsAndReproduction"]).to eq("")
          expect(object["linkResource"]).to eq("")
          expect(object["repository"]).to eq("Metropolitan Museum of Art, New York, NY")
          expect(object["objectURL"]).to eq("https://www.metmuseum.org/art/collection/search/436535")
          expect(object["tags"]).to eq([
                                         { "AAT_URL" => "http://vocab.getty.edu/page/aat/300132294",
                                          "Wikidata_URL"=>"https://www.wikidata.org/wiki/Q191163",
                                          "term" => "Landscapes" },
                                         { "AAT_URL" => "http://vocab.getty.edu/page/aat/300343641",
                                          "Wikidata_URL"=>"https://www.wikidata.org/wiki/Q146911", 
                                          "term" => "Cypresses" },
                                         { "AAT_URL" => "http://vocab.getty.edu/page/aat/300133099",
                                          "Wikidata_URL"=>"https://www.wikidata.org/wiki/Q1313", 
                                          "term" => "Summer" }
                                       ])
          expect(object["objectWikidata_URL"]).to eq "https://www.wikidata.org/wiki/Q18689458"
          expect(object["isTimelineWork"]).to eq true
          expect(object["GalleryNumber"]).to eq "822"
        end
      end

      context "Not Real objectID" do
        let(:objectID) { 0 }
        it "unsuccess with objectID" do
          expect { object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end

      context "Not enter objectID" do
        let(:objectID) { nil }
        it "unsuccess with objectID" do
          expect { object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end
    end

    describe "departments" do
      let(:department) { MetMuseum::Collection.new.department }
      context "all departments" do
        it "successful" do
          expect(department["departments"].size).to eq(19)
        end
      end
    end

    describe "search" do
      let(:search) do
        MetMuseum::Collection.new.search(q, { limit: limit,
                                              isHighlight: isHighlight,
                                              departmentId: departmentId })
      end
      let(:q) { "cat" }
      let(:limit) { 0 }
      let(:isHighlight) { false }
      let(:departmentId) { nil }
      context "real query" do
        it "successful search" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with limit" do
        let(:limit) { 1 }
        it "successful search with certain number" do
          expect(search.size).to eq(1)
          expect(search.first).to be_truthy
        end
      end

      context "with isHighlight" do
        let(:isHighlight) { true }
        it "successful search with isHighlight" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with title" do
        let(:title) { true }
        it "successful search with title" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with tags" do
        let(:tags) { true }
        it "successful search with tags" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with departmentId" do
        let(:departmentId) { 12 }
        it "successful search with departmentId" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with isOnView" do
        let(:isOnView) { true }
        it "successful search with isOnView" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with artistOrCulture" do
        let(:artistOrCulture) { true }
        it "successful search with artistOrCulture" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with medium" do
        let(:medium) { "Paintings" }
        it "successful search with medium" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with multi medium" do
        let(:medium) { %w[Paintings Sculpture] }
        it "successful search with medium" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with hasImages" do
        let(:hasImages) { true }
        it "successful search with hasImages" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with geoLocation" do
        let(:geoLocation) { "Paris" }
        it "successful search with geoLocation" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with multi geoLocation" do
        let(:geoLocation) { %w[Paris China] }
        it "successful search with geoLocation" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end

      context "with dateBegin and dateEnd" do
        let(:dateBegin) { Date.new(2017, 10, 10) }
        let(:dateEnd) { Date.new(2018, 10, 10) }
        it "successful search with dateBegin and dateEnd" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq search["total"]
        end
      end
    end
  end
end
