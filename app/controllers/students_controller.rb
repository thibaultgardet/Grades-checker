class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    if @student.save
      redirect_to @student, notice: 'Student created.'
    else
      render action: 'new'
    end
  end


  def all_actions
    render json: %w(index new create)
  end

  private
  def student_params
    params.require(:student).permit(:name)
  end
end
