class WeightsController < ApplicationController
  before_filter :authenticate_user!#, except: [:index]


  before_action :set_weight, only: [:show, :edit, :update, :destroy]
  before_action :set_rabbit, only: [:show, :edit, :new, :index, :destroy, :update]
  before_action :set_cage, only: [:show, :edit, :new, :index, :destroy, :update]


  # GET /weights
  # GET /weights.json
  def index
    @weights = @rabbit.weights
  end

  # GET /weights/1
  # GET /weights/1.json
  def show
  end

  # GET /weights/new
  def new
    @weight = @rabbit.weights.new(registered_on: Date.today, value: @rabbit.last_weight)
  end

  # GET /weights/1/edit
  def edit
  end

  # POST /weights
  # POST /weights.json
  def create
    @weight = Weight.new(weight_params)
    # Already present weight? Update it!
    @rabbit = @weight.rabbit
    @cage   = @rabbit.cage

    # already present weight on this date? update it
    present_weight = @rabbit.weights.where(registered_on: @weight.registered_on).first
    if present_weight
      present_weight.value = @weight.value
      @weight              = present_weight
    end

    respond_to do |format|
      if @weight.save

        format.html { redirect_to rabbit_weights_path(@weight.rabbit), notice: 'Peso registrato con successo.' }
        format.json { render :show, status: :created, location: @weight }
      else
        format.html { render :new }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weights/1
  # PATCH/PUT /weights/1.json
  def update
    respond_to do |format|
      if @weight.update(weight_params)
        format.html { redirect_to rabbit_weights_path(@rabbit), notice: 'Peso aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @weight }
      else
        format.html { render :edit }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weights/1
  # DELETE /weights/1.json
  def destroy
    @weight.destroy
    respond_to do |format|
      format.html { redirect_to rabbit_weights_path(@rabbit), notice: "Peso cancellato con successo" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight
      @weight = Weight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_params
      params.require(:weight).permit(:rabbit_id, :value, :registered_on)
    end

    def set_rabbit
      if @weight
        @rabbit = @weight.rabbit
      else
        @rabbit = Rabbit.find(params[:rabbit_id])
      end
    end

    def set_cage
      @cage = @rabbit.cage
    end
end
