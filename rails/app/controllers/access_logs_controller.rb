class AccessLogsController < ApplicationController
  before_action :admin_user!
  before_action :set_access_log, only: [:show, :edit, :update, :destroy]

  # GET /access_logs
  # GET /access_logs.json
  def index
    #@access_logs = AccessLog.user(params[:user_id]).date_from(params[:date_from]).date_to(params[:date_to]).page(params[:page]).per(25).decorate
    @access_logs = AccessLog.user(params[:user_id]).date_from(params[:date_from]).date_to(params[:date_to])
    @access_logs = @access_logs.where("fullpath like ?", "#{params[:url]}%") if params[:url].present?
    @access_logs = @access_logs.page(params[:page]).per(25).decorate
  end

  # GET /access_logs/1
  # GET /access_logs/1.json
  def show
  end

  # GET /access_logs/new
  def new
    @access_log = AccessLog.new
  end

  # GET /access_logs/1/edit
  def edit
  end

  # POST /access_logs
  # POST /access_logs.json
  def create
    @access_log = AccessLog.new(access_log_params)

    respond_to do |format|
      if @access_log.save
        format.html { redirect_to @access_log, notice: 'Access log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @access_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @access_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_logs/1
  # PATCH/PUT /access_logs/1.json
  def update
    respond_to do |format|
      if @access_log.update(access_log_params)
        format.html { redirect_to @access_log, notice: 'Access log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @access_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_logs/1
  # DELETE /access_logs/1.json
  def destroy
    @access_log.destroy
    respond_to do |format|
      format.html { redirect_to access_logs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_log
      @access_log = AccessLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_log_params
      params.require(:access_log).permit(:user_id, :ip, :remote_ip, :request_method, :fullpath)
    end
end
