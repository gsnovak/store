module Admin
  class AdminController < ApplicationController
    before_action :authorized?
    private
    def authorized?
      if current_user.nil? or !current_user.admin?
        flash[:error] = "You are not authorized to view that page."
        redirect_to '/'
      end
    end
  end
end
