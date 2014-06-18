class InstructorsController < ApplicationController
  #before_action :admin_user!
  before_action :set_instructor, only: [:show, :edit, :update, :destroy, :courses]

  # GET /instructors
  # GET /instructors.json
  def index
    #@instructors = Instructor.search(params[:kana]).page(params[:page]).decorate
    @instructors = Instructor.search(params[:name]).page(params[:page]).decorate
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        notice = "#{@instructor.name}先生を登録しました。"
        format.html { redirect_to @instructor, notice: notice }
        format.json { render action: 'show', status: :created, location: @instructor }
      else
        format.html { render action: 'new' }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        notice = "#{@instructor.name}先生を変更しました。"
        format.html { redirect_to @instructor, notice: notice }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1
  # DELETE /instructors/1.json
  def destroy
    notice = "#{@instructor.name}先生を削除しました。" if @instructor.destroy?
    @instructor.destroy if @instructor.destroy?
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def courses
    @courses = Course.where(instructor_id: @instructor.id).details
    respond_to do |format|
      format.html { render action: "courses" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:name, :kana, :team, :phone, :email_pc, :email_mobile, :transportation, :note)
    end
end
