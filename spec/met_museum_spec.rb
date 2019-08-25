RSpec.describe MetMuseum do

  describe 'Collection' do
    describe 'objects' do
      let(:objects) { MetMuseum::Collection.new().objects({metadataDate: metadataDate, departmentIds: departmentIds})}
      context "all data" do
        let(:metadataDate) {nil}
        let(:departmentIds) {nil}
        it "success" do
          expect(objects["objectIDs"]).to be_truthy
          expect(objects["total"]).to be_truthy
          expect(objects["objectIDs"].size).to eq (objects["total"])
        end
      end

      context "assign metadataDate" do
        context "Date" do
          let(:metadataDate) {Date.new(2018,10,10)}
          let(:departmentIds) {nil}
          it "success with DataType metadataDate" do
            expect(objects["objectIDs"]).to be_truthy
            expect(objects["total"]).to be_truthy
            expect(objects["objectIDs"].size).to eq (objects["total"])
          end
        end

        context "Datetime" do
          let(:metadataDate) {DateTime.new(2018,10,10)}
          let(:departmentIds) {nil}
          it "unsuccess with DatetimeType metadataDate" do
            expect{ objects["objectID"] }.to raise_error(MetMuseum::TypeError)
          end
        end
      end

      context "assign departmentIds" do
        context "Date" do
          let(:metadataDate) {nil}
          let(:departmentIds) {11111}
          it "success with DataType metadataDate" do
            expect(objects["objectIDs"]).to be_truthy
            expect(objects["total"]).to be_truthy
            expect(objects["objectIDs"].size).to eq (objects["total"])
          end
        end
      end
    end

    describe 'object' do
      let(:object) { MetMuseum::Collection.new().object(objectID) }
      context "Real objectID" do
        let(:objectID) {436535}
        it "success with objectID" do
          expect(object["objectID"]).to eq(objectID)
          expect(object["isHighlight"]).to eq(true)
          expect(object["accessionNumber"]).to eq("1993.132")
          expect(object["isPublicDomain"]).to eq(true)
          expect(object["primaryImage"]).to eq("https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg")
          expect(object["primaryImageSmall"]).to eq("https://images.metmuseum.org/CRDImages/ep/web-large/DT1567.jpg")
          expect(object["additionalImages"]).to eq ([
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-004.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-003.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-002.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-001.jpg",
          ])
          expect(object["constituents"]).to eq([
            {
              "role" => "Artist",
              "name" => "Vincent van Gogh"
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
          expect(object["tags"]).to eq(["Landscapes","Cypresses","Summer"])
        end
      end

      context "Not Real objectID" do
        let(:objectID) {0}
        it "unsuccess with objectID" do
          expect{ object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end

      context "Not enter objectID" do
        let(:objectID) {nil}
        it "unsuccess with objectID" do
          expect{ object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end
    end

    describe 'departments' do
      let(:department) {MetMuseum::Collection.new().department}
      context 'all departments' do
        it 'successful' do
          expect(department["departments"].size).to eq(19)
        end
      end
    end

    describe 'search' do
      let(:search) {MetMuseum::Collection.new().search(q, {limit: limit, isHighlight: isHighlight, departmentId: departmentId})}
      let(:q){ "cat" }
      let(:limit){ 0 }
      let(:isHighlight){ false }        
      let(:departmentId){ nil }
      context 'real query' do
        it "successful search" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end

      context 'with limit' do
        let(:limit){ 1 }
        it "successful search with certain number" do
          expect(search.size).to eq(1)
          expect(search.first).to be_truthy
        end
      end

      context 'with isHighlight' do
        let(:isHighlight){ true }
        it "successful search with certain number" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end

      context 'with departmentId' do        
        let(:departmentId){ 12 }
        it "successful search with certain number" do
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end
    end
  end
end
