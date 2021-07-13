class EventsController < ApplicationController
  before_action :authenticate_admin_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :destroy, :edit, :update]
  before_action :admin_user_authentication, only:[:destroy, :edit, :update]
  def index
    @events = Event.includes(:admin_user).order('created_at DESC')
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(:event_image, :name, :event_date,
                                  :content).merge(admin_user_id: current_admin_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def admin_user_authentication
    unless current_admin_user.id == @event.admin_user_id
      redirect_to root_path
    end
  end
end
