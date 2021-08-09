class EventsController < ApplicationController
  before_action :authenticate_admin_user!, except: %i[index show]
  before_action :set_event, only: %i[show destroy edit update]
  before_action :admin_user_authentication, only: %i[destroy edit update]
  def index
    @events = Event.includes(admin_user: :admin_profile).order('RAND()').limit(9)
    @admin_users = AdminUser.includes(:admin_profile).order('created_at DESC')
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
    @comment = Comment.new
    @comments = @event.comments.all
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to action: :show
    else
      render :edit
    end
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
    redirect_to root_path unless current_admin_user.id == @event.admin_user_id
  end
end
