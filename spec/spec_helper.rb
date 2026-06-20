require "bundler/setup"
require "met_museum"
require "webmock/rspec"
require "vcr"

require "date"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  # Record once; replay offline thereafter. Delete a cassette to re-record.
  config.default_cassette_options = { record: :once }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Wrap every example in a VCR cassette named after the example.
  config.around(:each) do |example|
    VCR.use_cassette(example.full_description.tr(" /", "__")) { example.run }
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
