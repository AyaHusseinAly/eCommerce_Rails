class AddUserToRateReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :rate_reviews, :user, foreign_key: true
  end
end
