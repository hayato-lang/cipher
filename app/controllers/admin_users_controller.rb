class AdminUsersController < ApplicationController
  def show
    admin_user = AdminUser.find(params[:id])
    @events = admin_user.events
  end
end
