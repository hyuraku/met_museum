RSpec.describe MetMuseum do

  describe 'Collection' do
    describe 'objects' do
      let(:objects) { MetMuseum::Collection.new().objects(metadataDate,departmentIds)}
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
      let(:search) {MetMuseum::Collection.new().search(q,limit)}
      context 'real query' do
        let(:q){"sunflowers"}
        let(:limit){ 0 }
        it "successful search" do
          expect(search["objectIDs"]).to be_truthy
          expect(search["total"]).to be_truthy
          expect(search["objectIDs"].size).to eq (search["total"])
        end
      end

      context 'with limit' do
        let(:q){"akasaka"}
        let(:limit){ 1 }
        it "successful search with certain number" do
          expect(search.size).to eq(1)
          expect(search.first).to be_truthy
        end
      end
    end
  end
end
