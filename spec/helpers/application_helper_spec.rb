# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'turbo_redirect' do
    it 'renders a turbo stream' do
      expect(helper.turbo_redirect('https://example.com')).to eq('<turbo-stream action="replace" target="turbo-redirect"><template><div data-controller="turbo--redirect-to" data-url="https://example.com"></div></template></turbo-stream>')
    end
  end

  describe '#svg_icon' do
    it 'render given svg filename' do
      expect(helper.svg_icon('youtube_button')).to eq "<svg height=\"100%\" version=\"1.1\" viewbox=\"0 0 68 48\" width=\"100%\"><path class=\"ytp-large-play-button-bg\" d=\"M66.52,7.74c-0.78-2.93-2.49-5.41-5.42-6.19C55.79,.13,34,0,34,0S12.21,.13,6.9,1.55 C3.97,2.33,2.27,4.81,1.48,7.74C0.06,13.05,0,24,0,24s0.06,10.95,1.48,16.26c0.78,2.93,2.49,5.41,5.42,6.19 C12.21,47.87,34,48,34,48s21.79-0.13,27.1-1.55c2.93-0.78,4.64-3.26,5.42-6.19C67.94,34.95,68,24,68,24S67.94,13.05,66.52,7.74z\" fill=\"#f00\"></path><path d=\"M 45,24 27,14 27,34\" fill=\"#fff\"></path></svg>"
    end

    it 'render given svg filename and CSS classes' do
      expect(helper.svg_icon('youtube_button', class: 'w-20 h-20')).to eq "<svg height=\"100%\" version=\"1.1\" viewbox=\"0 0 68 48\" width=\"100%\" class=\"w-20 h-20\"><path class=\"ytp-large-play-button-bg\" d=\"M66.52,7.74c-0.78-2.93-2.49-5.41-5.42-6.19C55.79,.13,34,0,34,0S12.21,.13,6.9,1.55 C3.97,2.33,2.27,4.81,1.48,7.74C0.06,13.05,0,24,0,24s0.06,10.95,1.48,16.26c0.78,2.93,2.49,5.41,5.42,6.19 C12.21,47.87,34,48,34,48s21.79-0.13,27.1-1.55c2.93-0.78,4.64-3.26,5.42-6.19C67.94,34.95,68,24,68,24S67.94,13.05,66.52,7.74z\" fill=\"#f00\"></path><path d=\"M 45,24 27,14 27,34\" fill=\"#fff\"></path></svg>"
    end
  end
end
