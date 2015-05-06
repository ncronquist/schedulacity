# schedulacity
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication.

## Finalized Name, Tag Line, Elevator Pitch
Schedulacity
Manage. Track. Schedule.
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication.

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
`has_many :classes`

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
`rails g model student name note:text dob:date email phone_number street_address city state zip notifications:boolean`

#### Associations
`has_and_belongs_to_many :classes`
`has_many :contacts`
`has_many :attendances`

### Class
  - id
  - name
  - description
  - user_id

#### Migration
`rails g model class name description:text user:references`

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
  - class_id

#### Migration
`rails g model event start:datetime end:datetime street_address city state zip class:references`

#### Associations
`belongs_to :class`
`has_many :attendances`

### Classes_Students
  - id
  - class_id
  - student_id

#### Migration
`rails g model classes_students class:references student:references --force-plural`

#### Associations

### Attendence
  - id
  - event_id
  - student_id
  - attendance_type

#### Migration
`rails g model attendance event:references student:references attendance_type:integer`

#### Associations
`belongs_to :event`
`belongs_to :user`

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

## Pages
### Homepage
### Signup Page - Employee
### Sign In
### Employee Index - shows list of classes (maybe calendar)
### Add Class
### Show Class

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

