RSpec.describe MetMuseum do
  let(:collection) { MetMuseum::Collection.new }

  describe "#objects" do
    # Scope to a single small department so the recorded cassette stays small:
    # the unscoped /objects listing returns ~500k ids.
    let(:department_id) { 15 } # The Robert Lehman Collection

    context "scoped to a department" do
      subject(:objects) { collection.objects(departmentIds: department_id) }

      it "returns the total and the matching object ids" do
        expect(objects["total"]).to be_a(Integer)
        expect(objects["objectIDs"]).to be_an(Array)
        expect(objects["objectIDs"].size).to eq(objects["total"])
      end
    end

    context "with a metadataDate" do
      subject(:objects) do
        collection.objects(metadataDate: metadata_date, departmentIds: department_id)
      end

      context "given a Date" do
        let(:metadata_date) { Date.new(2018, 10, 10) }

        it "accepts it and returns a parsed listing" do
          expect(objects["total"]).to be_a(Integer)
          expect(objects["objectIDs"]).to be_an(Array)
        end
      end

      context "given a DateTime" do
        let(:metadata_date) { DateTime.new(2018, 10, 10) }

        it "accepts it and returns a parsed listing" do
          expect(objects["total"]).to be_a(Integer)
          expect(objects["objectIDs"]).to be_an(Array)
        end
      end
    end
  end

  describe "#object" do
    subject(:object) { collection.object(id) }

    context "for a known object id" do
      let(:id) { 436_535 } # Van Gogh, Wheat Field with Cypresses

      # Assert the wrapper's responsibility (identity, presence and types of
      # fields) rather than The Met's exact metadata, which changes over time.
      it "returns the parsed record for that object" do
        expect(object["objectID"]).to eq(id)
        expect(object["title"]).to be_a(String)
        expect(object["artistDisplayName"]).to be_a(String)
        expect(object["primaryImage"]).to be_a(String)
        expect(object["additionalImages"]).to be_an(Array)
        expect(object["constituents"]).to be_an(Array)
        expect(object["measurements"]).to be_an(Array)
        expect(object).to have_key("isHighlight")
        expect(object).to have_key("isPublicDomain")
      end
    end

    context "for a non-existent object id" do
      let(:id) { 0 }

      it "raises NotFoundError" do
        expect { object }.to raise_error(MetMuseum::NotFoundError)
      end
    end

    context "for a nil object id" do
      let(:id) { nil }

      it "raises NotFoundError" do
        expect { object }.to raise_error(MetMuseum::NotFoundError)
      end
    end
  end

  describe "#department" do
    subject(:department) { collection.department }

    it "returns the list of departments" do
      expect(department["departments"]).to be_an(Array)
      expect(department["departments"]).not_to be_empty
      expect(department["departments"].first).to include("departmentId", "displayName")
    end
  end

  describe "#search" do
    subject(:search) { collection.search(query, **options) }
    let(:query) { "cat" }
    let(:options) { {} }

    shared_examples "a successful search listing" do
      it "returns the total and matching object ids" do
        expect(search["total"]).to be_a(Integer)
        expect(search["objectIDs"]).to be_an(Array)
        expect(search["objectIDs"].size).to eq(search["total"])
      end
    end

    context "with a plain query" do
      include_examples "a successful search listing"
    end

    context "with a limit" do
      let(:options) { { limit: 1 } }

      it "returns that many fully-fetched objects" do
        expect(search.size).to eq(1)
        expect(search.first["objectID"]).to be_a(Integer)
      end
    end

    context "with isHighlight" do
      let(:options) { { isHighlight: true } }

      include_examples "a successful search listing"
    end

    context "with title" do
      let(:options) { { title: false } }

      include_examples "a successful search listing"
    end

    context "with tags" do
      let(:options) { { tags: false } }

      include_examples "a successful search listing"
    end

    context "with departmentId" do
      let(:options) { { departmentId: 12 } }

      include_examples "a successful search listing"
    end

    context "with isOnView" do
      let(:options) { { isOnView: true } }

      include_examples "a successful search listing"
    end

    context "with artistOrCulture" do
      let(:options) { { artistOrCulture: true } }

      include_examples "a successful search listing"
    end

    context "with a single medium" do
      let(:options) { { medium: "Paintings" } }

      include_examples "a successful search listing"
    end

    context "with multiple mediums" do
      let(:options) { { medium: %w[Paintings Sculpture] } }

      include_examples "a successful search listing"
    end

    context "with hasImages" do
      let(:options) { { hasImages: true } }

      include_examples "a successful search listing"
    end

    context "with a geoLocation" do
      let(:options) { { geoLocation: "Paris" } }

      include_examples "a successful search listing"
    end

    context "with multiple geoLocations" do
      let(:options) { { geoLocation: %w[Paris China] } }

      include_examples "a successful search listing"
    end

    context "with dateBegin and dateEnd" do
      let(:options) { { dateBegin: 1000, dateEnd: 2018 } }

      include_examples "a successful search listing"
    end
  end
end
