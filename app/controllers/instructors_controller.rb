class InstructorsController < ApplicationController

  before_action :set_instructor, except: [:index, :new,]

  respond_to :html

  # GET /instructors
  def index
    @q = Instructor.joins(:courses).merge(Course.opened).distinct.search(params[:q])
    @instructors = @q.result.order(:name).page(params[:page]).decorate
  end

  # GET /instructors/1
  def show
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new(taxable: true)
  end

  # GET /instructors/1/edit
  def edit
  end

  # POST /instructors
  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      notice = "#{I18n.t('activerecord.models.instructor')}を登録しました。"
      redirect_to @instructor, notice: notice
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /instructors/1
  def update
    if @instructor.update(instructor_params)
      notice = "#{I18n.t('activerecord.models.instructor')}を変更しました。"
      redirect_to @instructor, notice: notice
    else
      render action: 'edit'
    end
  end

  # DELETE /instructors/1
  def destroy
    if @instructor.destroy?
      @instructor.destroy
      notice = "#{I18n.t('activerecord.models.instructor')}を削除しました。"
    end
    redirect_to instructors_url, notice: notice
  end

  # GET /instructors/1/courses
  def courses
    @courses = Course.where(instructor_id: @instructor.id)
    @courses = @courses.opened if params[:status] == '1'
    @courses = @courses.closed if params[:status] == '9'
    @courses = @courses.details
      .order(open_date: :desc)
      .merge(School.order(:open_date))
      .merge(Studio.order(:open_date))
      .merge(Timetable.order(:weekday))
    render action: "courses"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id] || params[:instructor_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:name, :kana, :team, :phone, :email_pc, :email_mobile, :transportation, :guaranteed_min, :taxable, :note)
    end
end
