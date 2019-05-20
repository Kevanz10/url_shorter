class UrlTitleExtractor
  def self.get_title(url)
    begin
      response = HTTParty.get(url, verify: false)
      Nokogiri::HTML::Document.parse(response.body).title
    rescue HTTParty::Error
      nil
    end
  end
end