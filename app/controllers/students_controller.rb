class StudentsController < ApplicationController

before_action :is_authenticated?

  def index
    @current_user = current_user
    @students = Student.where(user_id: @current_user.id).order('name ASC')
    # render :json => @students
  end

  def new
    @student = Student.new
    @current_user = current_user
  end

  def create
    # render :json => student_params
    # @student = Student.where(email:student_params['email'], user_id: student_params['user_id']).first_or_create(student_params)
    if Student.where(email:student_params['email'], user_id: student_params['user_id']).count > 0
      flash[:danger] = 'Student email already exists'
      redirect_to new_student_path
    else
      Student.create(student_params)
      redirect_to students_path
    end
  end


  def show
    @student = Student.find(params[:id])
    @student_classes = @student.classgroups
    # render :json => @student_classes
  end

  def edit
    @student = Student.find(params[:id])
    # render :json => @student
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to students_path
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.attendances.destroy
    @student.destroy
    redirect_to students_path
  end

  private

  def student_params
    params.require(:student).permit(:name,:note,:dob,:email,:phone_number,:street,:city,:state,:zip,:notifications,:user_id)
  end


end
