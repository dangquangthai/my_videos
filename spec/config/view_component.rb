# frozen_string_literal: true

require 'view_component/test_helpers'

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers,      type: :component
  config.include Capybara::RSpecMatchers,         type: :component
  config.include ActionView::Helpers::FormHelper, type: :component
  config.include ActionView::TestCase::Behavior,  type: :component
end
