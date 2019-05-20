class ShortUrl < ApplicationRecord

  URL_REGREX_VALIDATOR =  /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/
  RANDOM_CHARS = ['A'..'Z','a'..'z', '0'..'9'].freeze

  validates :url, presence: true
  validate :url_format_validator

  after_validation :set_url_shorter, :set_expiration_date, on: :create
  after_create :title_extractor

  scope :most_visited, -> (page, per_page)  { where("expiration_date >= ?", Time.now).order(visits_count: :desc)
                                              .paginate(page: page, per_page: per_page) }

  def increase_visits
    self.visits_count += 1
    self.save
  end

  def title_extractor
    UrlTitleWorker.perform_async(self.id)
  end

  private

    def url_format_validator
      message = "Invalid url. Match sure the url matches this format's example: https://www.example.com"
      errors[:base] << message unless self.url =~ URL_REGREX_VALIDATOR
    end

    def set_url_shorter
      begin 
        self.shorted_url = random_chars.sample(5).join("")
      end until ShortUrl.find_by(shorted_url: self.shorted_url).nil?
    end

    def set_expiration_date
      self.expiration_date = Time.now + 15.days
    end

    def random_chars
      RANDOM_CHARS.map(&:to_a).flatten
    end
end
