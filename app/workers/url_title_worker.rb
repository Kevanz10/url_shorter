class UrlTitleWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(id)
    short_url = ShortUrl.find(id)
    short_url.title = UrlTitleExtractor.get_title(short_url.url)
    short_url.save!
  end
end