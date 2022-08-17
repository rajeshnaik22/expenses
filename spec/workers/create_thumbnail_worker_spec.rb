# frozen_string_literal: true

require 'rails_helper'
require 'open-uri'

RSpec.describe CreateThumbnailWorker do
  subject(:perform) { instance.perform user.id }

  let(:instance) { described_class.new }
  let(:user) { create :user, **user_attr }
  let(:user_attr) { { picture: Faker::Internet.url } }

  describe 'perform' do
    context 'when picture not set' do
      let(:user_attr) { { picture: nil } }

      it 'does not create thumbnail' do
        expect(instance).not_to receive(:download_source_image)
        perform
      end
    end

    context 'when picture set' do
      before do
        puts 'running allow'
        allow(URI).to receive(:parse).and_return(double(open: 'some stream'))
        allow(IO).to receive(:copy_stream).and_return('Source file')
        allow(Media).to receive(:trim)
        allow(Filestack::API).to receive(:new).and_return(double('api', upload_file: OpenStruct.new(url: 'http://asdf.com')))
      end

      let(:user_attr) { { picture: Faker::Internet.url } }

      it 'downloads image' do
        expect(instance).to receive(:download_source_image)
        perform
      end

      it 'creates thumbnail' do
        perform
        expect(Media).to have_received(:trim)
      end

      it 'updates user with thumbnail url' do
        perform # reload is must else checks with old data
        expect(user.reload.thumbnail).to be_present
      end
    end
  end
end
