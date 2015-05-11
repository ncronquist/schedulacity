class ClassgroupsController < ApplicationController

  before_action :is_authenticated?

  def index
    @classes = Classgroup.all
  end

  def new
    @class = Classgroup.new
    @current_user = current_user
  end

  def create
    # render :json => params
    @class = Classgroup.create(classgroup_params)
    if @class.save
      redirect_to classgroups_path
    else
      render 'new'
    end
  end

  def show
    @class = Classgroup.find(params[:id])
    @students = @class.students

    @current_user = current_user
    @events = Event.where(classgroup_id: @class.id)
    # @event = @events.first.id
    # render :json => @event


  end

  def edit
    @class = Classgroup.find(params[:id])
  end

  def update
    @class = Classgroup.find(params[:id])
    if @class.update(classgroup_params)
      redirect_to classgroups_path
    else
    render 'edit'
    end
  end

  def destroy

  end

  ### Custom Routes  ###

  def students_add
    @class = Classgroup.find_by_id(params[:id])
    @enrolled_students = @class.students
    @student = Student.new
    @all_students = Student.all
    # render :json => @enrolled_students
  end

  def students_create
    @class = Classgroup.find(params[:id])
    # @student = Student.create(student_params)
    @class_student = @class.students.create(student_params)
    if @class_student.save
      redirect_to classgroup_path(params[:id])
    end
  end

  def students_update
    @class = Classgroup.find_by_id(params[:id])
    @class.students.clear
    class_students = params[:classgroup][:student_ids]
    class_students.each do |student_id|
      @class.students << Student.find(student_id) unless student_id.blank?
    end
    redirect_to classgroup_path(params[:id])
    # render :json => params
 end

  private

  def classgroup_params
    params.require(:classgroup).permit(:name,:description,:user_id)
  end

  def student_params
    params.require(:student).permit(:name,:note,:dob,:email,:phone_number,:street,:city,:state,:zip,:notifications)
  end

end


