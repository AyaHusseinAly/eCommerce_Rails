class UsersController < ApplicationController
    before_action :authenticate_user!  # handle Guest access

    def show
    end
end
