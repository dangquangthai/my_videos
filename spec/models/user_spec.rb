# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:followers).through(:follows) }
    it { should have_many(:videos).dependent(:destroy) }
  end
end
