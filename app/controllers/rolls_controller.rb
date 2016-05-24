class RollsController < ApplicationController

  before_action :set_lesson, only: [:index, :new, :create, :edit, :create_or_update,]

  # GET /lessons/:lesson_id/rolls
  # GET /lessons/:lesson_id/rolls.json
  def index
    if @lesson.in_process?
      # クラスを受講している会員の出欠情報
      rolls = @lesson.find_or_initialize_rolls
      # 振替の出席情報
      rolls.concat(@lesson.rolls.where(status: Roll::STATUS[:SUBSTITUTE]))
    else
      rolls = @lesson.rolls
    end
    @rolls = rolls.map(&:decorate)
  end

  # GET /rolls/1
  # GET /rolls/1.json
  def show
    @roll = Roll.find(params[:id]).decorate
  end

  # GET /rolls/new
  def new
    @roll = Roll.new
    [:lesson_id, :member_id, :status, :substitute_roll_id].each do |key|
      @roll.assign_attributes(key => params[key])
    end
  end

  # GET /lessons/:lesson_id/rolls/edit
  def edit
    index
  end

  # POST /lesson/:lesson_id/rolls
  def create_or_update
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(status: Lesson::STATUS[:ON_SCHEDULE],
                                rolls_status: Lesson::ROLLS_STATUS[:IN_PROCESS])
      params[:rolls].each do |roll_params|
        # 出欠情報を取得（または作成）する。
        roll = Roll.find_or_initialize_by(lesson_id: @lesson.id, member_id: roll_params[:member_id])
        roll.status = roll_params[:status]
        roll.substitute_roll_id = roll_params[:substitute_roll_id]
        logger.info("roll: #{roll}")
        case roll.status
        when Roll::STATUS[:NONE],
             Roll::STATUS[:ATTENDANCE],
             Roll::STATUS[:ABSENCE],
             Roll::STATUS[:RECESS],
             Roll::STATUS[:CANCEL] then
          roll.save
        when Roll::STATUS[:SUBSTITUTE] then
          roll.substitute
        when "9" then
          roll.cancel_substitute
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson), notice: "出席簿を保存しました。" }
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
