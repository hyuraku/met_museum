RSpec.describe MetMuseum do

  describe 'Collection' do
    describe 'objects' do
      let(:objects) { MetMuseum::Collection.objects(metadataDate)}
      context "all data" do
        let(:metadataDate) {nil}
        it "success" do
          expect(objects["objectIDs"].size).to eq (objects["total"])
        end
      end

      context "assign metadataDate" do
        let(:metadataDate) {'2018-10-10'}
        it "success with metadataDate" do
          expect(objects["total"]).to eq(87031)
          expect(objects["objectIDs"].size).to eq (objects["total"])
        end
      end

    end

    describe 'object' do
      let(:object) { MetMuseum::Collection.object(objectID) }
      context "Real objectID" do
        let(:objectID) {1000}
        it "success with objectID" do
          expect(object["objectID"]).to eq(objectID)
          expect(object["isPublicDomain"]).to eq(true)
          expect(object["objectName"]).to eq("Bread plate")
          expect(object["objectURL"]).to eq("https://www.metmuseum.org/art/collection/search/#{objectID}")
        end
      end

      context "Unreal objectID" do
        let(:objectID) {999999}
        it "failure with id" do
          expect(object["message"]).to eq ("ObjectID not found")
        end
      end
    end
  end
end
