class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :url
      t.string :shorted_url
      t.string :title
      t.integer :visits_count, default: 0
      t.timestamps
    end
  end
end
