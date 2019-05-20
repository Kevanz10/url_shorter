require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:url) { ShortUrl.new(url: 'https://example.com') }

  it 'should generate a short, 5 letters, url with a valid url' do
    url.save!
    
    expect(url).to be_valid
    expect(url.shorted_url.size).to eq 5
    expect(url.shorted_url).to match(/\A[0-9a-zA-Z]{5}\z/)
  end

  it 'should display an error when url is not valid' do
    url.url = '243'
    url.save
    expect(url).to be_invalid
    expect(url.errors.messages[:base]).to include("Invalid url. Match sure the url matches this format's example: https://www.example.com")
  end
end
