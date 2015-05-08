class StudentsController < ApplicationController

before_action :is_authenticated?

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    # render :json => params
    @student = Student.find_or_create_by(email: student_params[:email]) || Student.create(student_params)
    if @student.save
      redirect_to students_path
    else
      render 'new'
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

  end

  private

  def student_params
    params.require(:student).permit(:name,:note,:dob,:email,:phone_number,:street,:city,:state,:zip,:notifications)
  end


end
