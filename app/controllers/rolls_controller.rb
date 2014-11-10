class RollsController < ApplicationController
  # 体験は設計ミスのため削除する。
  before_action :set_lesson, only: [:index, :new, :create, :edit, :create_or_update, :absentees, :substitute]

  # GET /lessons/:lesson_id/rolls
  # GET /lessons/:lesson_id/rolls.json
  def index
    if @lesson.in_process?
      # クラスを受講している会員の出欠情報
      rolls = @lesson.find_or_initialize_rolls
      # 振替の出席情報
      rolls.concat(@lesson.rolls.where(status: "4"))
    else
      rolls = @lesson.rolls
    end
    @rolls = rolls.map { |roll| roll.decorate }
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
    #@rolls = @lesson.rolls
    index
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
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(rolls_status: Lesson::ROLLS_STATUS[:IN_PROCESS])
      params[:rolls].each do |roll_params|
        roll = Roll.find(roll_params[:id])
        roll.update_attributes(status: roll_params[:status])
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson) }
    end
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

  # POST /lesson/:lesson_id/rolls
  def create_or_update
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(status: Lesson::STATUS[:ON_SCHEDULE], rolls_status: Lesson::ROLLS_STATUS[:IN_PROCESS])
      params[:rolls].each do |roll_params|
        # 出欠情報を取得（または作成）する。
        roll = Roll.find_or_initialize_by(lesson_id: @lesson.id, member_id: roll_params[:member_id])
        roll.status = roll_params[:status]
        if roll.status != "9"
          # ステータスが9:取り消し以外の場合は保存する。
          roll.save
        elsif roll.substitute_roll_id.blank?
          # ステータスが9:取り消しで、振替のロールIDがない場合は出欠情報を削除する。
          roll.destroy
        else
          # ステータスが9:取り消しで、振替のロールIDがある場合は振替のロールIDを削除する。
          roll.cancel_substitute
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson) }
    end
  end

  def absentees
    exclude_members = @lesson.rolls.joins(:member)
    @q = Roll.absences.joins(:lesson, :member).merge(Lesson.fixed).where.not(member_id: exclude_members.pluck(:member_id)).search(params[:q])
    if params[:q].present?
      @rolls = @q.result
      @members = Member.where(id: @rolls.pluck(:member_id).uniq).page(params[:page]).decorate
    else
      @members = Member.none
    end
  end

  def substitute
    if params[:member_id].nil?
      redirect_to lesson_rolls_path(@lesson)
      return
    end
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(rolls_status: Lesson::ROLLS_STATUS[:IN_PROCESS])
      @lesson.find_or_initialize_rolls.each do |roll|
        roll.save if roll.new_record?
      end
      roll = Roll.where(member_id: params[:member_id]).absences.joins(:lesson).readonly(false).order('"lessons"."date"').first
      roll.substitute(@lesson)
    end
    respond_to do |format|
      format.html { redirect_to edit_lesson_rolls_path(@lesson) }
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
