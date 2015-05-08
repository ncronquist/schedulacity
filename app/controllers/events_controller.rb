class EventsController < ApplicationController

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

end
