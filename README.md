# Schedulacity
Manage. Track. Schedule.
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication. Schedulacity makes it easy to keep track of your clients. With contact information storage and notes for each client, you can keep track of what matters most. You text message them directly through the app. Scheduling one-off or repeating sessions is a breeze with schedulacity and the attendance tracker helps to make sure you don't lose track of anyone.

![enter image description here](https://raw.githubusercontent.com/ncronquist/schedulacity/master/app/assets/images/placeit.png)

![enter image description here](https://raw.githubusercontent.com/ncronquist/schedulacity/master/app/assets/images/class-show.png)

![enter image description here](https://raw.githubusercontent.com/ncronquist/schedulacity/master/app/assets/images/calendar.png)

## Technologies Used
Schedulacity is built with Ruby on Rails.

APIs:
  - Google Oauth and Calendar
  - Twilio (Text-messaging)

Gems:
  - Bootstrap_form (Beautiful, easy, forms)
  - Font-awesome-rails
  - Pry-rails (Makes Pry beautiful)
  - Omniauth and the Omniauth-Google-Oauth2 Strategy
  - Rest-client
  - Google-Api-Client
  - Momentjs-Rails (Awesome date manipulation)
  - Bootstrap3-datetimepicker-rails (One of the better date-time pickers out there)
  - Fullcalendar-rails (Super easy and full-featured calendar)

## Approach

The main goal of this project was to make a clean and easy to use management app for independent instructors. Version 1 of Schedulacity focused strongly on this goal from the instructor point of view. For future versions, we would like to make it even easier for instructors with features like:
  - Attendance confirmation via text messaging
  - Student/Client side login and class signup
  - Payment managment

### Wireframes
 ![enter image description here](http://i.imgur.com/usWrzDL.jpg)
 ![enter image description here](http://i.imgur.com/rCQIAdg.jpg)

### ER-Diagram
![ER-Diagram](https://raw.githubusercontent.com/ncronquist/schedulacity/master/app/assets/images/ERDiagram.jpg)

## Issues
This web app is currently in beta testing. Known issues:
- Google calendar events don't get deleted if you disconnect from Schedulacity from Google account
- Adding repeating events where the day of the selected event isn't a day checked in the repeat days list will throw an error

# Original Setup Information

## Models V1

### User
  - id
  - name
  - email
  - password_digest
  - phone_number
  - provider
  - provider_id
  - provider_hash

#### Migration
`rails g model user name email password_digest phone_number provider provider_id provider_hash`

#### Associations
`has_many :classgroups`

### Student
  - id
  - name
  - note
  - dob
  - email
  - phone_number
  - street_address
  - city
  - state
  - zip
  - notifications

#### Migration
`rails g model student name note:text dob:date email phone_number street city state zip notifications:boolean`

#### Associations
`has_and_belongs_to_many :classgroups`
`has_many :contacts`
`has_many :attendances`
`has_many :events, through: :attendances`

### Classgroup
  - id
  - name
  - description
  - user_id

#### Migration
`rails g model classgroup name description:text user:references`

#### Associations
`has_and_belongs_to_many :students`
`belongs_to :user`
`has_many :events`

### Event
  - id
  - start (datetime)
  - end (datetime)
  - street_address
  - city
  - state
  - zip
  - note
  - classgroup_id

#### Migration
`rails g model event start:datetime end:datetime street_address city state zip classgroup:references`

#### Associations
`belongs_to :classgroup`
`has_many :attendances`
`has_many :students, through: :attendances`

### Classgroups_Students
  - id
  - classgroup_id
  - student_id

#### Migration
`rails g model classgroups_students classgroup:references student:references --force-plural`

#### Associations

### Attendance
  - id
  - event_id
  - student_id
  - attendance_type

#### Migration
`rails g model attendance event:references student:references attendance_type:integer --force-plural`

#### Associations
`belongs_to :student`
`belongs_to :event`

## Models V2

### Contacts
  - id
  - name
  - email
  - phone_number
  - street_address
  - city
  - state
  - zip
  - relation
  - student_id

#### Migration
`rails g model contact name email phone_number street_address city state zip relation student:references`

#### Associations
`belongs_to :student`

# Archive Information
## Tag Line Ideas
Simple client management and scheduling
Simple client scheduling and attendance
Client managment; Simple to set up; Simple to use
Integrated Client Managment, Scheduling, and Attendance
Manage. Schedule. Attendance.
Managing. Scheduling. Attendance.
Manage. Track. Schedule.

## Elevator Pitch Ideas
Simple client management software that allows you to schedule sessions, track attendance, and handle communication.
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication.
