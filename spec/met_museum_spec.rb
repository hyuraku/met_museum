RSpec.describe MetMuseum do

  describe 'Collection' do
    describe 'objects' do
      let(:objects) { MetMuseum::Collection.new().objects(metadataDate)}
      context "all data" do
        let(:metadataDate) {nil}
        it "success" do
          expect(objects["objectIDs"].size).to eq (objects["total"])
        end
      end

      context "assign metadataDate" do
        let(:metadataDate) {'2018-10-10'}
        it "success with metadataDate" do
          expect(objects["objectIDs"].size).to eq (objects["total"])
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
    end

    describe 'search' do
      let(:search) {MetMuseum::Collection.new().search(q)}
      context 'real query' do
        let(:q){"sunflowers"}
        it "successful search" do
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end
    end
  end
end
