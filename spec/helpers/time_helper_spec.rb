# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeHelper, type: :helper do
  describe 'time_humanize' do
    context 'when time is nil' do
      it 'returns nil' do
        expect(helper.time_humanize(nil)).to be_nil
      end
    end

    context 'when time is present' do
      it 'returns formatted time' do
        time = Time.zone.parse('2024-01-01 12:00:00')
        expect(helper.time_humanize(time)).to eq('Jan 01, 2024 12:00')
      end
    end
  end
end
