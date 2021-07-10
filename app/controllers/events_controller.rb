class EventsController < ApplicationController
  def index
    @events = Event.includes(:admin_user).order('created_at DESC')
  end
end
