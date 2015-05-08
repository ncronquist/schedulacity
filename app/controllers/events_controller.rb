class EventsController < ApplicationController

  before_action :is_authenticated?

  def index
  end

  def show
  end

  def new
    @event = Event.new
    ### FOR TESTING PURPOSES ONLY
      @classgroups = Classgroup.all
    ### REPLACE WITH
      # @classgroups = @current_user.classgroups
    ### END TEST

  end

  def create
    render :json => params
  end

  def edit
  end

  def update
  end

  def destroy
  end

  ### METHOD TO DISPLAY CALENDAR EVENTS ###
  respond_to :json
  def get_events
    puts 'method fired'
    @events = Event.all
    events = []
    @events.each do |event|
      events << {:id => event.id, :start => event.start, :end => event.end }
    end
    render :text => events.to_json
  end

end
