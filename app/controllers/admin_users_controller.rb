class AdminUsersController < ApplicationController
  def show
    admin_user = AdminUser.find(params[:id])
    @store_name = admin_user.store_name
    @events = admin_user.events
    @admin_profile = admin_user.admin_profile
  end
end
