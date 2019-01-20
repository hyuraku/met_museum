# MetMuseum

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/met_museum`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
  490607}

MetMuseum::Collection.object(1000)
=> {"objectID"=>1000,
 "isHighlight"=>false,
 "accessionNumber"=>"10.149.99",
 "isPublicDomain"=>true,
 --< omit >--
 "repository"=>"Metropolitan Museum of Art, New York, NY",
 "objectURL"=>"https://www.metmuseum.org/art/collection/search/1000"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hyuraku/met_museum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MetMuseum project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/met_museum/blob/master/CODE_OF_CONDUCT.md).
