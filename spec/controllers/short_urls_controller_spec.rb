require 'rails_helper'
require 'short_urls_controller'

RSpec.describe ShortUrlsController, type: :controller do
  let(:short_url) { ShortUrl.create(url: 'https://google.com') }

  describe 'Get /:short_url_id' do
    it 'should redirect to original URL' do
      get :redirection, params: {short_url_id: short_url.shorted_url}
      expect(response).to redirect_to(short_url.url)
    end

    it 'should redirect to the error page' do
      get :redirection, params: {short_url_id: 123}
      expect(response).to redirect_to(url_not_found_path)
    end
  end
end
