 <img src="https://img.shields.io/github/license/hyuraku/met_museum.svg"> <img src="https://img.shields.io/gem/v/met_museum.svg">
# MetMuseum

The Metropolitan Museum of Art Collection API Ruby wrapper

The API document is [here](https://metmuseum.github.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'met_museum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install met_museum

## Usage

```rb
require 'met_museum'
```

The description of the method is as follows

<details>
<summary>
MetMuseum::Collection.objects
</summary>
<div>

```rb
collection = MetMuseum::Collection.new()
collection.objects
=> {"total"=>494788,
 "objectIDs"=>
  [1,
   2,
   3,
   4,
--< omit >--
  826602]}

 collection.objects(metadataDate: Date.new(2018,10,10))
 =>{"total"=>355400,
  "objectIDs"=>
   [33,
    35,
    36,
    74,
    75,
 --< omit >--
    826307]}

collection.objects(departmentIds: 1)
=> {"total"=>18572,
 "objectIDs"=>
  [1,
   2,
   3,
   4,
 --< omit >--
   821352]}

collection.objects(metadataDate: Date.new(2018,10,10),departmentIds: 1)
=> {"total"=>15439,
 "objectIDs"=>
  [7,
   8,
   33,
   34,
 --< omit >--
   816271]}

```
</div>
</details>



<details>
<summary>
  MetMuseum::Collection.object
</summary>
<div>

```rb
MetMuseum::Collection.new.object(1000)
=> {"objectID"=>1000,
 "isHighlight"=>false,
 "accessionNumber"=>"10.149.99",
 "isPublicDomain"=>true,
 "primaryImage"=>"https://images.metmuseum.org/CRDImages/ad/original/DP258638.jpg",
 "primaryImageSmall"=>"https://images.metmuseum.org/CRDImages/ad/web-large/DP258638.jpg",
 "additionalImages"=>[],
 "constituents"=>nil,
 "department"=>"The American Wing",
 "objectName"=>"Bread plate",
 "title"=>"Bread Plate",
 "culture"=>"Chinese, for American market",
 "period"=>"",
 "dynasty"=>"",
 "reign"=>"",
 "portfolio"=>"",
 "artistRole"=>"",
 "artistPrefix"=>"",
 "artistDisplayName"=>"",
 "artistDisplayBio"=>"",
 "artistSuffix"=>"",
 "artistAlphaSort"=>"",
 "artistNationality"=>"",
 "artistBeginDate"=>"",
 "artistEndDate"=>"",
 "objectDate"=>"1785–90",
 "objectBeginDate"=>1785,
 "objectEndDate"=>1790,
 "medium"=>"Porcelain",
 "dimensions"=>"Diam. 6 1/4 in. (15.9 cm)",
 "creditLine"=>"Bequest of James T. Woodward, 1910",
 "geographyType"=>"Made in",
 "city"=>"",
 "state"=>"",
 "county"=>"",
 "country"=>"China",
 "region"=>"",
 "subregion"=>"",
 "locale"=>"",
 "locus"=>"",
 "excavation"=>"",
 "river"=>"",
 "classification"=>"Ceramics",
 "rightsAndReproduction"=>"",
 "linkResource"=>"",
 "metadataDate"=>"2019-01-30T09:08:07.74Z",
 "repository"=>"Metropolitan Museum of Art, New York, NY",
 "objectURL"=>"https://www.metmuseum.org/art/collection/search/1000"}
 "tags"=>["Coat of Arms", "Dishes"]}
```
</div>
</details>

<details>
<summary>
MetMuseum::Collection.department
</summary>
<div>

```rb
# show object_ids size and themselves
MetMuseum::Collection.new.department
=> {"departments"=>
  [{"departmentId"=>1, "displayName"=>"American Decorative Arts"},
   {"departmentId"=>3, "displayName"=>"Ancient Near Eastern Art"},
   {"departmentId"=>4, "displayName"=>"Arms and Armor"},
   {"departmentId"=>5, "displayName"=>"Arts of Africa, Oceania, and the Americas"},
   {"departmentId"=>6, "displayName"=>"Asian Art"},
   {"departmentId"=>7, "displayName"=>"The Cloisters"},
   --< omit >--

```
</div>
</details>

<details>
<summary>
MetMuseum::Collection.search
</summary>
<div>

```rb
# show object_ids size and themselves
MetMuseum::Collection.new.search('ocean')
=> {"total"=>189,
 "objectIDs"=>
  [250487,
   12544,
   436005,
   8314,
   8315,
   8317,
   --< omit >--

# show specified number of objects
MetMuseum::Collection.new.search('akasaka', {limit: 1})
=> [{"objectID"=>37231,
  "isHighlight"=>false,
  "accessionNumber"=>"JP787",
  "isPublicDomain"=>true,
  "primaryImage"=>"https://images.metmuseum.org/CRDImages/as/original/DP123261.jpg",
  "primaryImageSmall"=>"https://images.metmuseum.org/CRDImages/as/web-large/DP123261.jpg",
  "additionalImages"=>[],
  "constituents"=>[{"role"=>"Artist", "name"=>"Utagawa Hiroshige"}],
  "department"=>"Asian Art",
  "objectName"=>"Print",
  "title"=>"Akasaka",
  "culture"=>"Japan",
  "period"=>"Edo period (1615–1868)",
  "dynasty"=>"",
  "reign"=>"",
  "portfolio"=>"",
  "artistRole"=>"",
  "artistPrefix"=>"",
  "artistDisplayName"=>"",
  "artistDisplayBio"=>"",
  "artistSuffix"=>"",
  "artistAlphaSort"=>"",
  "artistNationality"=>"",
  "artistBeginDate"=>"",
  "artistEndDate"=>"",
  "objectDate"=>"ca. 1840",
  "objectBeginDate"=>1830,
  "objectEndDate"=>1850,
  "medium"=>"Polychrome woodblock print; ink and color on paper",
  "dimensions"=>"Overall: 8 3/4 x 13 3/4in. (22.2 x 34.9cm)",
  "creditLine"=>"The Francis Lathrop Collection, Purchase, Frederick C. Hewitt Fund, 1911",
  "geographyType"=>"",
  "city"=>"",
  "state"=>"",
  "county"=>"",
  "country"=>"",
  "region"=>"",
  "subregion"=>"",
  "locale"=>"",
  "locus"=>"",
  "excavation"=>"",
  "river"=>"",
  "classification"=>"Prints",
  "rightsAndReproduction"=>"",
  "linkResource"=>"",
  "metadataDate"=>"2019-05-11T05:36:53.803Z",
  "repository"=>"Metropolitan Museum of Art, New York, NY",
  "objectURL"=>"https://www.metmuseum.org/art/collection/search/37231",
  "tags"=>["Buildings", "Men", "Women"]}]


# show object_ids size and themselves with certain departmentId --< omit >--
MetMuseum::Collection.new.search('flower', {departmentId: 12})
=> {"total"=>7922,
 "objectIDs"=>
  [207138,
   197555,
   207151,
   206979,
   --< omit >--

# show object_ids size and themselves which are isOnView
MetMuseum::Collection.new.search('flower', {isOnView: true})
=> => {"total"=>2066,
 "objectIDs"=>
  [207138,
   3689,
   11207,
   252906,
   252349,
   --< omit >--

# show object_ids size and themselves which are artistOrCulture
MetMuseum::Collection.new.search('flower', {artistOrCulture: true})
=>  {"total"=>5, "objectIDs"=>[207138, 3689, 196563, 196560, 198662]}


# show object_ids size and themselves with certain medium
MetMuseum::Collection.new.search('flower', {medium: "Paintings"})
=> {"total"=>706,
 "objectIDs"=>
  [11207,
   436121,
   10481,
   435882,
   --< omit >--


# show object_ids size and themselves which are hasImages
MetMuseum::Collection.new.search('flower', {hasImages: true})
=> {"total"=>18731,
 "objectIDs"=>
  [207138,
   3689,
   11207,
   252906,
   --< omit >--

# show object_ids size and themselves with certain geoLocation
MetMuseum::Collection.new.search('flower', {geoLocation: "Paris"})
=> {"total"=>292,
 "objectIDs"=>
  [195320,
   707455,
   193814,
   200432,
   --< omit >--

# show object_ids size and themselves with datarange
MetMuseum::Collection.new.search('flower', {dateBegin: 1700,dateEnd: 1750})
=> {"total"=>1444,
 "objectIDs"=>
  [9199,
   3759,
   398162,
   666591,
   --< omit >--
```
</div>
</details>

***

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hyuraku/met_museum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MetMuseum project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hyuraku/met_museum/blob/master/CODE_OF_CONDUCT.md).
