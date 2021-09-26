class LikesController < ApplicationController
  before_action :authenticate_any!, only: %i[destroy create]
  before_action :post_params

  def create
    Like.create(user_id: current_user&.id, event_id: params[:id], admin_user_id: current_admin_user&.id)
  end

  def destroy
    Like.find_by(user_id: current_user&.id, event_id: params[:id], admin_user_id: current_admin_user&.id).destroy
  end

  private

  def post_params
    @event = Event.find(params[:id])
  end

  def authenticate_any!
    redirect_to root_path unless admin_user_signed_in? || user_signed_in?
  end
end
