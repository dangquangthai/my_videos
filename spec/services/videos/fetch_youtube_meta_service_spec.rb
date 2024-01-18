# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Videos::FetchYoutubeMetaService, type: :service do
  fixtures :videos

  describe '#perform' do
    subject { described_class.new(video: video) }

    context 'when video url is invalid' do
      context 'is tiktok' do
        let(:video) { videos(:tiktok_video) }

        it 'updates video meta and change status from new to failed' do
          expected_error_message = 'It is not YouTube video url'

          expect do
            subject.perform
          end.to change { video.reload.title }.from(nil).to(expected_error_message)
             .and change { video.description }.from(nil).to(expected_error_message)
             .and change { video.status }.from('new').to('failed')
        end
      end

      context 'is unavailable' do
        let(:video) { videos(:unavailable_video) }

        it 'updates video meta and change status from new to failed' do
          expected_error_message = 'This video is not available'

          expect do
            subject.perform
          end.to change { video.reload.title }.from(nil).to(expected_error_message)
             .and change { video.description }.from(nil).to(expected_error_message)
             .and change { video.status }.from('new').to('failed')
        end
      end
    end

    context 'when video url is valid' do
      context "can't connect to YouTube" do
        let(:video) { videos(:new_video) }

        before do
          expect(subject).to receive(:can_connect_to_youtube?).and_return(false)
        end

        it 'updates video meta and change status from new to failed' do
          expected_error_message = "Can't connect to YouTube"

          expect do
            subject.perform
          end.to change { video.reload.title }.from(nil).to(expected_error_message)
             .and change { video.description }.from(nil).to(expected_error_message)
             .and change { video.status }.from('new').to('failed')
        end
      end

      context 'can connect to YouTube' do
        context 'when video is new' do
          let(:video) { videos(:new_video) }

          it 'updates video meta and change status from new to ready' do
            expected_title = 'Buried Secrets of the Bible with Albert Lin: Sodom & Gomorrah (Full Episode) | National Geographic'
            expected_description = 'Albert Lin reveals real events behind the epic biblical story of Sodom and Gomorrah.Enjoy a free trial of National Geographic right here: https://ngmdomsubs....'

            expect do
              subject.perform
            end.to change { video.reload.title }.from(nil).to(expected_title)
               .and change { video.description }.from(nil).to(expected_description)
               .and change { video.video_id }.from(nil).to('hInAmmQSfI4')
               .and change { video.status }.from('new').to('ready')
          end
        end

        context 'when video is failed' do
          let(:video) { videos(:failed_video) }

          it 'updates video meta and change status from failed to ready' do
            expected_title = 'The Ocean 4K - Scenic Wildlife Film With Calming Music'
            expected_description = 'The Ocean is one of the most incredible places on earth. Enjoy this 4K Scenic Wildlife Film featuring the diverse animals and scenery of the ocean. From vibr...'

            expect do
              subject.perform
            end.to change { video.reload.title }.from('This video is not available').to(expected_title)
               .and change { video.description }.from('This video is not available').to(expected_description)
               .and change { video.video_id }.from(nil).to('eoTpdTU8nTA')
               .and change { video.status }.from('failed').to('ready')
          end
        end

        context 'when video is published' do
          let(:video) { videos(:published_video) }

          it 'do not change' do
            expect do
              expect do
                expect do
                  subject.perform
                end.not_to(change { video.reload.status })
              end.not_to(change { video.title })
            end.not_to(change { video.description })
          end
        end
      end
    end
  end
end
