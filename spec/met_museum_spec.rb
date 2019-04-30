RSpec.describe MetMuseum do

  describe 'Collection' do
    describe 'objects' do
      let(:objects) { MetMuseum::Collection.new().objects(metadataDate)}
      context "all data" do
        let(:metadataDate) {nil}
        it "success" do
          expect(objects["objectIDs"]).to be_truthy
          expect(objects["total"]).to be_truthy
          expect(objects["objectIDs"].size).to eq (objects["total"])
        end
      end

      context "assign metadataDate" do
        context "Date" do
          let(:metadataDate) {Date.new(2018,10,10)}
          it "success with metadataDate" do
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
        let(:objectID) {1000}
        it "success with objectID" do
          expect(object["objectID"]).to eq(objectID)
          expect(object["isPublicDomain"]).to eq(true)
          expect(object["objectName"]).to eq("Bread plate")
          expect(object["objectURL"]).to eq("https://www.metmuseum.org/art/collection/search/#{objectID}")
        end
      end

      context "Not Real objectID" do
        let(:objectID) {0}
        it "success with objectID" do
          expect{ object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end

      context "Not enter objectID" do
        let(:objectID) {nil}
        it "success with objectID" do
          expect{ object["objectID"] }.to raise_error(MetMuseum::NotFoundError)
        end
      end
    end

    describe 'search' do
      let(:search) {MetMuseum::Collection.new().search(q)}
      let(:search_detail) {MetMuseum::Collection.new().search(q,show_number)}
      context 'real query' do
        let(:q){"sunflowers"}
        it "successful search" do
          expect(search["objectIDs"]).to be_truthy
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end

      context 'with detail-all' do
        let(:q){"akasaka"}
        let(:show_number){ 'all' }
        it "successful search with detail all" do
          expect(search_detail.size).to eq(9)
          expect(search_detail.first).to be_truthy
        end
      end

      context 'with detail-1' do
        let(:q){"akasaka"}
        let(:show_number){ 1 }
        it "successful search with certain number" do
          expect(search_detail.size).to eq(1)
          expect(search_detail.first).to be_truthy
        end
      end
    end
  end
end
