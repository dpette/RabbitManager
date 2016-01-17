class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!#, except: [:index]

  # GET /cages
  # GET /cages.json
  def index
    @cages = Cage.all
  end

  # GET /cages/1
  # GET /cages/1.json
  def show
  end

  # GET /cages/new
  def new
    @cage = Cage.new
  end

  # GET /cages/1/edit
  def edit
  end

  # POST /cages
  # POST /cages.json
  def create
    @cage = Cage.new(cage_params)

    if cage_params[:compartment_count].present?
      (1..cage_params[:compartment_count]).each do |i|
        @cage.compartments.new(code: i)
      end
    end

    respond_to do |format|
      if @cage.save
        format.html { redirect_to @cage, notice: 'Cage was successfully created.' }
        format.json { render :show, status: :created, location: @cage }
      else
        format.html { render :new }
        format.json { render json: @cage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cages/1
  # PATCH/PUT /cages/1.json
  def update
    respond_to do |format|
      if @cage.update(cage_params)
        format.html { redirect_to @cage, notice: 'Cage was successfully updated.' }
        format.json { render :show, status: :ok, location: @cage }
      else
        format.html { render :edit }
        format.json { render json: @cage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cages/1
  # DELETE /cages/1.json
  def destroy
    @cage.destroy
    respond_to do |format|
      format.html { redirect_to cages_url, notice: 'Cage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cage
      @cage = Cage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cage_params
      params.require(:cage).permit(:name, :code, :farm_id, :type, :compartment_count)
    end
end