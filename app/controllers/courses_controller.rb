# frozen_string_literal: true

class CoursesController < AdminController
  before_action :find_course, only: %i[ show edit update destroy ]
  before_action :check_currency_exist, only: %i[new create edit udpate]
  before_action :check_category_exist, only: %i[new create edit udpate]

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path
  end

  private
    def find_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :price, :currency_id, :category_id, :status, :slug, :description, :valid_period)
    end

    def check_currency_exist
      redirect_to new_currency_path if Currency.count.zero?
    end

    def check_category_exist
      redirect_to new_category_path if Category.count.zero?
    end
end
