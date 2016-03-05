class CagesController < ApplicationController
  before_filter :authenticate_user!#, except: [:index]

  before_action :set_cage, only: [:show, :edit, :update, :destroy]
  before_action :set_farm, only: [:index, :new]


  before_filter :set_cage_type

  # GET /cages
  # GET /cages.json
  def index
    @fattening_cages  = FatteningCage.where(farm_id: @farm.id)
    @motherhood_cages = MotherhoodCage.where(farm_id: @farm.id)
    @weaning_cages    = WeaningCage.where(farm_id: @farm.id)
    @race_cages       = RaceCage.where(farm_id: @farm.id)
  end

  # GET /cages/1
  # GET /cages/1.json
  def show
    render "#{@cage.model_name.route_key}/show"
  end

  # GET /cages/new
  def new
    @cage = @farm.cages.new(type: class_name_by_controller)
  end

  # GET /cages/1/edit
  def edit
  end

  # POST /cages
  # POST /cages.json
  def create
    @cage = Cage.new(cage_params)

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
      params.require(class_instance_name_by_controller.to_sym).
        permit(:name, :code, :farm_id, :type, :compartments_size)
    end

    def set_farm
      if current_user.farms.size > 1
        @farm = current_user.farms.find(params[:farm_id])
      else
        @farm = current_user.farms.first
      end
    end

    def set_cage_type
      @cage_type = class_instance_name_by_controller
    end
end
