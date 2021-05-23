class CouponController < ApplicationController
    before_action :authenticate_user!  # handle Guest access

end
