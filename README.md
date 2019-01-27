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

```
require 'met_museum'

MetMuseum::Collection.objects
=> {"total"=>490607,
 "objectIDs"=>
  [1,
   2,
   3,
   4,
   5,
   6,
   7,
   8,
--< omit >--
  820613]}

MetMuseum::Collection.objects('2018-10-10')
=>{"total"=>88232,
 "objectIDs"=>
  [33,
   35,
   36,
   74,
   75,
--< omit >--
   820613]}

MetMuseum::Collection.object(1000)
=> {"objectID"=>1000,
 "isHighlight"=>false,
 "accessionNumber"=>"10.149.99",
 "isPublicDomain"=>true,
 --< omit >--
 "repository"=>"Metropolitan Museum of Art, New York, NY",
 "objectURL"=>"https://www.metmuseum.org/art/collection/search/1000"}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hyuraku/met_museum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MetMuseum project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/met_museum/blob/master/CODE_OF_CONDUCT.md).
