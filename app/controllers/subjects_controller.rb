class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_courses

  def show; end

  def new
    @subject = Subject.new
  end

  def edit; end

  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to admin_index_path, notice: I18n.t('alert.course.create') }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to admin_index_path, notice: I18n.t('alert.course.update') }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: I18n.t('alert.course.delete') }
      format.json { head :no_content }
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def set_courses
    @courses = Course.all.pluck(:name, :id)
  end

  def subject_params
    params.require(:subject).permit(:name, course_ids: [])
  end
end
