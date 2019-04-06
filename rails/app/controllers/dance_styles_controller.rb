class DanceStylesController < ApplicationController
  before_action :set_dance_style, only: [:show, :edit, :update, :destroy]

  # GET /dance_styles
  # GET /dance_styles.json
  def index
    @dance_styles = DanceStyle.page(params[:page])
  end

  # GET /dance_styles/1
  # GET /dance_styles/1.json
  def show
  end

  # GET /dance_styles/new
  def new
    @dance_style = DanceStyle.new
  end

  # GET /dance_styles/1/edit
  def edit
  end

  # POST /dance_styles
  # POST /dance_styles.json
  def create
    @dance_style = DanceStyle.new(dance_style_params)

    respond_to do |format|
      if @dance_style.save
        format.html { redirect_to @dance_style, notice: 'Dance style was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dance_style }
      else
        format.html { render action: 'new' }
        format.json { render json: @dance_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dance_styles/1
  # PATCH/PUT /dance_styles/1.json
  def update
    respond_to do |format|
      if @dance_style.update(dance_style_params)
        format.html { redirect_to @dance_style, notice: 'Dance style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dance_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dance_styles/1
  # DELETE /dance_styles/1.json
  def destroy
    @dance_style.destroy
    respond_to do |format|
      format.html { redirect_to dance_styles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dance_style
      @dance_style = DanceStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dance_style_params
      params.require(:dance_style).permit(:name, :order_no)
    end
end
