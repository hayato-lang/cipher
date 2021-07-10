class EventsController < ApplicationController
  def index
    @events = Event.includes(:admin_user).order('created_at DESC')
  end


  def new
    @event = Event.new
  end

  def create
  end
end
