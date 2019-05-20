class AddExpirationDateToShortUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :short_urls, :expiration_date, :datetime
  end
end
