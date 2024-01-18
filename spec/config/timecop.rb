# frozen_string_literal: true

# https://thoughtbot.com/blog/its-about-time-zones

RSpec.configure do |config|
  config.before(:each, freeze: true) do |example|
    Timecop.freeze(example.metadata[:freeze])
  end

  config.after(:each, freeze: true) do
    Timecop.return
  end
end
