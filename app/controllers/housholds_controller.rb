class HousholdsController < ApplicationController
  before_action :set_houshold, only: [:show, :edit, :update, :destroy]

  # GET /housholds
  # GET /housholds.json
  def index
    @housholds = Houshold.all
  end

  # GET /housholds/1
  # GET /housholds/1.json
  def show
  end

  # GET /housholds/new
  def new
    @houshold = Houshold.new
  end

  # GET /housholds/1/edit
  def edit
  end

  # POST /housholds
  # POST /housholds.json
  def create
    @houshold = Houshold.new(houshold_params)

    respond_to do |format|
      if @houshold.save
        format.html { redirect_to @houshold, notice: 'Houshold was successfully created.' }
        format.json { render :show, status: :created, location: @houshold }
      else
        format.html { render :new }
        format.json { render json: @houshold.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housholds/1
  # PATCH/PUT /housholds/1.json
  def update
    respond_to do |format|
      if @houshold.update(houshold_params)
        format.html { redirect_to @houshold, notice: 'Houshold was successfully updated.' }
        format.json { render :show, status: :ok, location: @houshold }
      else
        format.html { render :edit }
        format.json { render json: @houshold.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housholds/1
  # DELETE /housholds/1.json
  def destroy
    @houshold.destroy
    respond_to do |format|
      format.html { redirect_to housholds_url, notice: 'Houshold was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_houshold
      @houshold = Houshold.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def houshold_params
      params.require(:houshold).permit(:name)
    end
end
