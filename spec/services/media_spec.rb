# frozen_string_literal: true

require 'rails_helper'
require 'fastimage'

RSpec.describe Media do
  let(:test_file) { Pathname.new(Rails.root.join('spec/images/test.jpg')) }
  let(:resized_file_path) { 'tmp/resized.jpg' }
  let(:resized_image) { Pathname.new(resized_file_path) }

  before do
    resized_image.unlink if resized_image.exist?
    expect(resized_image.exist?).to be(false)
  end

  it 'creates resized file' do
    described_class.trim(test_file.to_s, resized_file_path, width: 100, height: 50)
    expect(resized_image.exist?).to be_truthy
  end

  it 'resizes the image' do
    described_class.trim(test_file.to_s, resized_file_path, width: 100, height: -1)
    expect(FastImage.size(resized_file_path)).to eq [100, 66]
  end
end
