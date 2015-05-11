class ClassgroupsController < ApplicationController

  before_action :is_authenticated?

  def index
    @classes = Classgroup.all
  end

  def new
    @class = Classgroup.new
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
    @class = Classgroup.find(params[:id])
    @class.destroy
    redirect_to classgroups
  end

  ### Custom Routes  ###

  def students_add
    @class = Classgroup.find_by_id(params[:id])
    @enrolled_students = @class.students
    @student = Student.new
    @current_user = current_user
    @all_students = Student.where(user_id: @current_user.id)
    # render :json => @enrolled_students
  end

  def students_create
    @class = Classgroup.find(params[:id])
    if Student.where(email:student_params['email'],user_id:student_params['user_id']).count == 0
      @class_student = @class.students.create(student_params)
      redirect_to "/classgroups/#{params[:id]}/students"
    else
      redirect_to "/classgroups/#{params[:id]}/students"
      flash[:danger] = 'Student email already exists'
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
    params.require(:student).permit(:name,:note,:dob,:email,:phone_number,:street,:city,:state,:zip,:notifications,:user_id)
  end

end


