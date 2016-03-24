class RabbitsController < ApplicationController
  before_filter :authenticate_user!#, except: [:index]


  before_action :set_rabbit, only: [:show, :edit, :update, :destroy, :kill, :birth, :new_birth, :new_conception, :conception, :edit_notes, :available_cages, :move]
  before_action :set_cage,   only: [:show, :edit, :new, :index, :kill, :destroy, :new_birth, :new_conception, :conception, :edit_notes, :available_cages, :move]

  before_filter :set_rabbit_type

  # GET /rabbits
  # GET /rabbits.json
  def index
    @rabbits = Rabbit.all
  end

  # GET /rabbits/1
  # GET /rabbits/1.json
  def show
    @weights = @rabbit.weights.order("registered_on DESC")
  end

   # GET /rabbits/new
  def new
    if params[:container_id].present? && params[:container_type].present?
      container_id   = params[:container_id]
      container_type = params[:container_type]
    else
      container_id   = @cage.id
      container_type = "Cage"
    end
    @rabbit = Rabbit.new(
      type: class_name_by_controller,
      container_id: container_id,
      container_type: container_type
    )
  end

  # GET /rabbits/1/edit
  def edit
    @fields = params[:fields]
  end

  # POST /rabbits
  # POST /rabbits.json
  def create
    @rabbit = Rabbit.new(rabbit_params)
    puts @rabbit.to_yaml
    @cage   = @rabbit.cage

    respond_to do |format|
      if @rabbit.save
        format.html { redirect_to rabbit_path(@rabbit), notice: 'Coniglio creato con successo.' }
        format.json { render :show, status: :created, location: @rabbit }
      else
        flash[:error] =  @rabbit.errors.full_messages.to_sentence
        format.html { render :new }
        format.json { render json: @rabbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rabbits/1
  # PATCH/PUT /rabbits/1.json
  def update
    respond_to do |format|
      if @rabbit.update(rabbit_params)
        format.html { redirect_to @rabbit, notice: 'Coniglio aggiornato con succcesso.' }
        format.json { render :show, status: :ok, location: @rabbit }
      else
        format.html { render :edit }
        format.json { render json: @rabbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rabbits/1
  # DELETE /rabbits/1.json
  def destroy
    @rabbit.destroy
    respond_to do |format|
      format.html { redirect_to cage_path(@cage), notice: 'Coniglio elimiato con successo.' }
      format.json { head :no_content }
    end
  end

  def kill
    @rabbit.kill params[:death_date]

    respond_to do |format|
      format.html { redirect_to cage_path(@cage), notice: "Registrata uccisione del coniglio"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rabbit
      @rabbit = Rabbit.find(params[:id])
    end

    def set_cage
      if @rabbit.present?
        @cage = @rabbit.cage
      else
        @cage = Cage.find(params[:cage_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rabbit_params
      params.require(class_instance_name_by_controller.to_sym).
        permit(:name, :container_id, :container_type, :type, :gender, :notes, :birth_date, :death_date)
    end

    def set_rabbit_type
      @rabbit_type = class_instance_name_by_controller
    end


end
