class CreateRateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_reviews do |t|
      t.string :rating
      t.text :content

      t.timestamps
    end
  end
end
