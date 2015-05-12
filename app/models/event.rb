require 'google/api_client'

class Event < ActiveRecord::Base

  belongs_to :classgroup
  has_many :attendances
  has_many :students, through: :attendances

  before_destroy do |record|
    if record.google_event_id
      user = record.classgroup.user
      client = Google::APIClient.new(:application_name => 'Schedulacity',
                                      :application_version => '1.0')
      client.authorization.access_token = user.provider_hash
      service = client.discovered_api('calendar', 'v3')

      result = client.execute(:api_method => service.events.delete,
                              :parameters => {'calendarId' => 'primary',
                                              'eventId' => record.google_event_id})
    end
  end
end
