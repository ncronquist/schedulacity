# schedulacity
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication.

## Finalized Name, Tag Line, Elevator Pitch
Schedulacity
Manage. Track. Schedule.
Cloud based client management software that allows you to schedule sessions, track attendance, and handle communication.

## Models V1

### Employees
  - id
  - name
  - email
  - password_digest
  - phone_number
  - provider
  - provider_id
  - provider_hash

#### Migration
`rails g model employee name email password_digest phone_number provider provider_id provider_hash`

#### Associations
`has_many :classes`

### Students
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
`rails g model name note:text dob:date email phone_number street_address city state zip notifications:boolean`

#### Associations
`has_and_belongs_to_many :classes`
`has_many :contacts`
`has_many :attendances`

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

### Classes
  - id
  - name
  - description
  - employee_id

#### Migration
`rails g model class name description:text employee:references`

#### Associations
`has_and_belongs_to_many :students`
`belongs_to :employee`
`has_many :sessions`

### Session
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
`rails g model session start:datetime end:datetime street_address city state zipclass:references`

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
  - session_id
  - student_id
  - attendance_type

#### Migration
`rails g model attendance session:references student:references attendance_type:integer`

#### Associations
`belongs_to :session`
`belongs_to :user`

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

