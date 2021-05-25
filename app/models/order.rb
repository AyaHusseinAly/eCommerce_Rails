class Order < ApplicationRecord
    has_many:order_details
    belongs_to:user
    belongs_to:store
    
    #add scopes accoring to the status of the order
    scope :delivered, ->{where(status:"Delivered")}
    scope :pending, ->{where(status:"Pending")}
    scope :confirmed, ->{where(status:"Confirmed")}

    validates :status,
    inclusion: { in: %w(Pending Confirmed Delivered)}


    after_update :order_status_update_email
    private
    def order_status_update_email
        @order = Order.order("updated_at").last
        OrderMailer.order_status_change(@order).deliver_later

    end


end

