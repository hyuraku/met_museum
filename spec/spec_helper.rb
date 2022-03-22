require "bundler/setup"
require "met_museum"
require "rspec/retry"

require "date"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.around :each do |ex|
    ex.run_with_retry retry: 3
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
