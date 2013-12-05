class EventsController < ApplicationController
before_filter :set_current_user 
def new 
    # default: render 'new' template
  end
def index
  @events = Event.all
end
def create
    @event = Event.create!(params[:event])
    @league = League.find_by_league_admin(@current_user.user_id)
    if @league
    @event.update_attributes!(:eventscope => @league[:league_name])
    else
    @event.update_attributes!(:eventscope => 'Global Event')
    end
    flash[:notice] = "#{@event.eventdesp} was successfully created."
    redirect_to events_path
  end
end
