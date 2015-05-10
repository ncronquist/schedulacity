class EventsController < ApplicationController

  before_action :is_authenticated?

  def index
    @event = Event.last
  end

  def show
  end

  def new
    @event = Event.new
    @classgroups = @current_user.classgroups
  end

  def create
    # render :json => params

    # def create_event(start_dtm,
    #                 end_dtm,
    #                 classgroup_id,
    #                 street,
    #                 city,
    #                 state,
    #                 zip)
    def create_event(start_dtm,
                    end_dtm,
                    classgroup_id)
      # Create new event
      event = Event.new
      event.start = start_dtm
      event.end = end_dtm
      # event.street = street
      # event.city = city
      # event.state = state
      # event.zip = zip
      event.save

      # Associate event to classgroup
      classgroup = Classgroup.find(classgroup_id)
      classgroup.events << event

      # Check if user has linked their google account and if so create
      # the event with google too
      if @current_user.provider
        create_google_event(start_dtm,
                            end_dtm,
                            classgroup_id,
                            street,
                            city,
                            state,
                            zip)
      end
    end

    def create_google_event(start_dtm,
                            end_dtm,
                            classgroup_id,
                            street,
                            city,
                            state,
                            zip)


    end

    # Instantiate variables
    start_dtm = DateTime.strptime(params[:event][:start] + ' ' + params[:UTC],
                                  '%m/%d/%Y %H:%M %p %z')
    end_dtm = DateTime.strptime(params[:event][:end] + ' ' + params[:UTC],
                                '%m/%d/%Y %H:%M %p %z')
    classgroup_id = params[:event][:classgroup_id]

    if !params[:repeat][:repeat]
      # Not a repeating event
      # Add single instance of the event
      create_event(start_dtm, end_dtm, classgroup_id)

    else
      # Repeating event
      # Add multiple instances of the event

      # Get variables
      reoccurrence_type = params[:repeat][:reoccurrence_type]
      reoccurrence_period = params[:repeat][:reoccurrence_period].to_i
      first_event_start = DateTime.strptime(params[:event][:start] + ' ' + params[:UTC], '%m/%d/%Y %H:%M %p %z')
      first_event_end = DateTime.strptime(params[:event][:end] + ' ' + params[:UTC], '%m/%d/%Y %H:%M %p %z')
      days = []
      params[:repeat][:days].each do |k,v|
        days << v.to_i
      end
      end_mode = params[:repeat][:until]
      if end_mode == "repeat_times"
        occurrences = params[:repeat][:until_times].to_i
      else
        last_event = Date.strptime(params[:repeat][:until_end], '%m/%d/%Y')
      end

      # eventObj = {}
      # eventObj['reoccurrence_type'] = reoccurrence_type
      # eventObj['reoccurrence_period'] = reoccurrence_period
      # eventObj['first_event_start'] = first_event_start
      # eventObj['first_event_end'] = first_event_end
      # eventObj['days'] = days
      # eventObj['end_mode'] = end_mode
      # eventObj['occurrences'] = occurrences || 0
      # eventObj['last_event'] = last_event || Date.new(1900,1,1)

      # render :json => eventObj

      event_start = first_event_start
      event_end = first_event_end
      # first_event = Date.strptime(event_start, '%m/%d/%Y')
      occurrences = occurrences || 9999999999
      last_event = last_event || Date.new(9999,12,31)
      events_created = 0
      week = 1

      loop do
        days.each_with_index do |day,idx|
          # If it's teh first week and the day is less than the event start day,
          # skip to the next day
          next if week == 1 && day < event_start.wday

          # If the event_start is greater than the last event or if we have
          # already created enough occurences, break out of the loop
          break if event_start > last_event + 1.day || events_created >= occurrences

          create_event(event_start, event_end, classgroup_id)

          # Update the never of events created
          events_created += 1

          # Update the next event_start date
          if idx < days.length - 1
            days_to_change = days[idx+1] - day
            event_start += days_to_change.day
          end

        end

        # Update the week counter
        week += 1

        days_to_change = days.last - days.first
        event_start += reoccurrence_period.week
        event_start -= days_to_change.day

        break if event_start > last_event || events_created > occurrences
      end
    end # end if !repeat

    redirect_to events_path

  end # end def create

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

###########################################################################
###########################################################################
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
#             freq: "1",
#             days: {
#                     sun: "0",
#                     mon: "1",
#                     tue: "2",
#                     wed: "3",
#                     thu: "4",
#                     fri: "5",
#                     sat: "6"
#                   },
#             until: "repeat_times",
#             until_times: "28"
#           },
#   commit: "Save Event",
#   controller: "events",
#   action: "create"
#
#   OTHER OPTIONS
#   until: "repeat_end",
#   until_end: "08/26/2015"
# }
