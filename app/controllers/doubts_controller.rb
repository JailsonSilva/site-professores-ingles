class DoubtsController < ApplicationController
  before_action :set_doubt, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /doubts
  # GET /doubts.json
  def index
    @doubts = Doubt.all
  end

  # GET /doubts/1
  # GET /doubts/1.json
  def show
  end

  # GET /doubts/new
  def new
    @doubt = Doubt.new
  end

  # GET /doubts/1/edit
  def edit
  end

  # POST /doubts
  # POST /doubts.json
  def create
    @doubt = Doubt.new(doubt_params)
    @doubt.user = current_user
    respond_to do |format|
      if @doubt.save
        format.html { redirect_to @doubt, notice: 'Doubt was successfully created.' }
        format.json { render :show, status: :created, location: @doubt }
      else
        format.html { render :new }
        format.json { render json: @doubt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doubts/1
  # PATCH/PUT /doubts/1.json
  def update
    respond_to do |format|
      if @doubt.user == current_user || current_user.admin?
        if @doubt.update(doubt_params)
          format.html { redirect_to @doubt, notice: 'Doubt was successfully updated.' }
          format.json { render :show, status: :ok, location: @doubt }
        else
          format.html { render :edit }
          format.json { render json: @doubt.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @doubt, notice: 'You do not have permission to do this'}
        format.json { render :show, status: :ok, location: @doubt }
      end
    end
  end

  # DELETE /doubts/1
  # DELETE /doubts/1.json
  def destroy
    if @doubt.user == current_user || current_user.admin?
      @doubt.destroy
      respond_to do |format|
        format.html { redirect_to doubts_url, notice: 'Doubt was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to doubts_url, notice: 'You do not have permission to do this.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doubt
      @doubt = Doubt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doubt_params
      params.require(:doubt).permit(:title, :content)
    end
end
