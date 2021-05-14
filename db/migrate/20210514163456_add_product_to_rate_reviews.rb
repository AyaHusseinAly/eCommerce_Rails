class AddProductToRateReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :rate_reviews, :product, foreign_key: true
  end
end
