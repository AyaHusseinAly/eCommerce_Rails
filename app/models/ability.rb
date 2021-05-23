# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= AdminUser.new
    if user.kind_of? User


    else
      alias_action :create,:read, :update, :destroy, :to=> :crud
      alias_action :read, :update, :destroy, :to=> :rud

      if user.role == 'admin'
        can :read, :all
        can :crud, [AdminUser,User,Brand,Category,Coupon,Store]
      elsif user.role == 'seller'
        can :crud, Product, Product.all do |product|
          product.store.in?(user.stores)
        end
        can :create, Product
        can :rud, Order, Order.all do |order|
          order.store.in?(user.stores)
        end
        can :rud, [Store], :admin_user_id=>user.id
        can :read, :all
      end


    end    

  end
end
