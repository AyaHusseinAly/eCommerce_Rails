class OrderMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def order_status_change(order)
      @order = order
      @url  = 'http://localhost:3000/'
      mail(to: @order.user.email, subject: 'Your order status changed')
    end
end
