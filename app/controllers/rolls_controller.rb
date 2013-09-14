class RollsController < ApplicationController
  #before_action :set_roll, only: [:show, :edit, :update, :destroy]
  before_action :set_lesson, only: [:index, :edit, :update]

  # GET /lessons/:lesson_id/rolls
  # GET /lessons/:lesson_id/rolls.json
  def index
    #@rolls = Roll.all
    #@lesson = Lesson.find(params[:lesson_id])
    @rolls = []
    MembersCourse.where(course_id: @lesson.course_id).date_is(@lesson.date).each do |members_course|
      attributes = { lesson_id: @lesson.id, member_id: members_course.member_id }
      if @lesson.date <= Date.today
        @rolls << Roll.find_or_create_by(attributes) do |roll|
          roll.status = "0"
        end
      else
        @rolls << Roll.find_or_initialize_by(attributes) do |roll|
          roll.status = "0"
        end
      end
    end
  end

  # GET /rolls/1
  # GET /rolls/1.json
  def show
  end

  # GET /rolls/new
  def new
    @roll = Roll.new
  end

  # GET /lessons/:lesson_id/rolls/edit
  def edit
    @rolls = @lesson.rolls
  end

  # POST /rolls
  # POST /rolls.json
  def create
    @roll = Roll.new(roll_params)

    respond_to do |format|
      if @roll.save
        format.html { redirect_to @roll, notice: 'Roll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @roll }
      else
        format.html { render action: 'new' }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rolls/1
  # PATCH/PUT /rolls/1.json
  def update
    params[:rolls].each do |roll_params|
      roll = Roll.find(roll_params[:id])
      roll.update_attributes(status: roll_params[:status])
    end
    redirect_to lesson_rolls_url(@lesson)
    #respond_to do |format|
    #  if @roll.update(roll_params)
    #    format.html { redirect_to @roll, notice: 'Roll was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @roll.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /rolls/1
  # DELETE /rolls/1.json
  def destroy
    @roll.destroy
    respond_to do |format|
      format.html { redirect_to rolls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def set_roll
      @roll = Roll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roll_params
      params.require(:roll).permit(:lesson_id, :member_id, :status, :substitute_roll_id)
    end
end
