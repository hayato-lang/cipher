class EventsController < ApplicationController
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

  private
  def event_params
    params.require(:event).permit(:event_image, :name, :event_date, :content).merge(admin_user_id: current_admin_user.id)
  end
end
