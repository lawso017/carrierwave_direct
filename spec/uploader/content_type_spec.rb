# encoding: utf-8

require 'spec_helper'

describe CarrierWaveDirect::Uploader::ContentType do
  subject { DirectUploader.new }

  describe "#content_type" do
    it "should default to binary/octet-stream" do
      [nil,true,false].each do |value|
        allow(subject.class).to receive(:will_include_content_type).and_return(value)
        allow(subject.class).to receive(:default_content_type).and_return(value)
        expect(subject.content_type).to eq 'binary/octet-stream'
      end
    end

    it "should be the configured value" do
      allow(subject.class).to receive(:will_include_content_type).and_return(nil)
      allow(subject.class).to receive(:default_content_type).and_return('video/mp4')
      expect(subject.content_type).to eq 'video/mp4'
    end

    it "should use 'will_include_cnotent_types' value if availableb" do
      subject.class.stub(:default_content_type).and_return nil
      subject.class.stub(:will_include_content_type).and_return 'video/mp4'
      expect(subject.content_type).to eq 'video/mp4'
    end
  end

  describe "#content_types" do
    it "should default to common media types" do
      expect(subject.content_types).to eq %w(application/atom+xml application/ecmascript application/json
                                            application/javascript application/octet-stream application/ogg
                                            application/pdf application/postscript application/rss+xml
                                            application/font-woff application/xhtml+xml application/xml
                                            application/xml-dtd application/zip application/gzip audio/basic
                                            audio/mp4 audio/mpeg audio/ogg audio/vorbis audio/vnd.rn-realaudio
                                            audio/vnd.wave audio/webm image/gif image/jpeg image/pjpeg image/png
                                            image/svg+xml image/tiff text/cmd text/css text/csv text/html
                                            text/javascript text/plain text/vcard text/xml video/mpeg video/mp4
                                            video/ogg video/quicktime video/webm video/x-matroska video/x-ms-wmv
                                            video/x-flv)
    end

    it "should be the configured value" do
      allow(subject.class).to receive(:allowed_content_types).and_return(['audio/ogg'])
      expect(subject.content_types).to eq ['audio/ogg']
    end
  end
end
