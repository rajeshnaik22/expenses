require 'rails_helper'
require 'open-uri'

RSpec.describe CreateThumbnailWorker do
    let(:instance) {described_class.new }
    subject{instance.perform user.id}
    
    let(:user){ create :user, **user_attr }
    let(:user_attr) {  {picture: Faker::Internet.url} }

    describe "perform" do

        context "when picture not set" do
            let(:user_attr) { { picture: nil } }
            it "should not create thumbnail" do
                expect(instance).not_to receive(:download_source_image)
                subject
            end
        end

        context "when picture set" do
            before do
                puts "running allow"
                allow(URI).to receive(:open)
                allow(IO).to receive(:copy_stream).and_return("Source file")
                allow(Media).to receive(:trim)
                allow(Filestack::API).to receive(:new).and_return(double("api", upload_file: OpenStruct.new(url: "http://asdf.com")))
            end

            let(:user_attr) {  {picture: Faker::Internet.url} }
            it "should download image" do
                expect(instance).to receive(:download_source_image)
                subject
            end

            it "should create thumbnail" do
                expect(Media).to receive(:trim)
                subject          
            end

            it "should update user with thumbnail url" do
                subject #reload is must else checks with old data
                expect(user.reload.thumbnail).to be_present

            end
        end

end
end


class Tester
    def self.test
        aa=IO.copy_stream(URI.open("http://example.asd"),"tere")
        puts aa
        download_source_image
        aa
    end

    def self.download_source_image
        image_url = Faker::Internet.url
        puts "download_source_image #{image_url}"

        IO.copy_stream(image_url, "tempfile")
    end
end
