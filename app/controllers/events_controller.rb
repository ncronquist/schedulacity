class EventsController < ApplicationController

  before_action :is_authenticated?

  def index
    @event = Event.last
  end

  def show
    @class = Classgroup.find(params[:id])
    @events = Event.where(classgroup_id: @class.id)
    @students = @class.students

    # @attendances = Attendance.new
    # @attendnces = Attendance.type
    # render :json => @attendances
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
    # render :json => params

    @classgroup = Classgroup.find(params[:event][:classgroup_id])

    # render :json => @classgroup[:id]
    # render :json => !params[:repeat][:repeat]
    # render :json => params[:event][:start]
    # render :json => DateTime.strptime(params[:event][:start] + ' ' + params[:UTC], '%m/%d/%Y %H:%M %p %z')

    if !params[:repeat][:repeat]
      # Add single instance of the event
      @event = Event.new
      @event.start = DateTime.strptime(params[:event][:start] + ' ' + params[:UTC], '%m/%d/%Y %H:%M %p %z')
      @event.end = DateTime.strptime(params[:event][:end] + ' ' + params[:UTC], '%m/%d/%Y %H:%M %p %z')
      @event.save

      @classgroup.events << @event
    else
      # Add multiple instances of the event
    end

    redirect_to events_path

    # end
    # {
    #   utf8: "✓",
    #   authenticity_token: "DdFqQ08qnIetmob8aJW89H3K8bdHiVZmdrl448FE2Xm1Z4edA+9ZN8G8vnX2TieTTtJXnk0ssZ3wFgIIfXR7Mg==",
    #   event:  {
    #             classgroup_id: "1",
    #             start: "05/11/2015 5:30 PM",
    #             end: "05/11/2015 6:30 PM"
    #           },
    #   repeat: {
    #             repeat: "true",
    #             freqtype: "Weekly",
    #             freq: "1 weeks",
    #             days: {
    #                     sun: "Sunday",
    #                     mon: "Monday",
    #                     tue: "Tuesday",
    #                     wed: "Wednesday",
    #                     thu: "Thursday",
    #                     fri: "Friday",
    #                     sat: "Saturday"
    #                   },
    #             until: "repeat_times",
    #             until_times: "28"
    #           },
    #   commit: "Save Event",
    #   controller: "events",
    #   action: "create"
    # }
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
    @events = Event.all
    events = []
    @events.each do |event|
      events << {:id => event.id, :title => Classgroup.find(event.classgroup_id).name, :start => event.start, :end => event.end, :url => "http://localhost:3000/classgroups/#{event.classgroup_id}"}
    end
    render :text => events.to_json
  end

end
