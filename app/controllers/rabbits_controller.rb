class RabbitsController < ApplicationController
  before_action :set_rabbit, only: [:show, :edit, :update, :destroy, :kill, :birth, :new_birth, :new_conception, :conception, :edit_notes, :new_move]
  before_action :set_cage,   only: [:show, :edit, :new, :index, :kill, :destroy, :new_birth, :new_conception, :conception, :edit_notes, :new_move]

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
    @rabbit = @cage.rabbits.new(type: class_name_by_controller)
  end

  # GET /rabbits/1/edit
  def edit
  end

  # POST /rabbits
  # POST /rabbits.json
  def create
    @rabbit = Rabbit.new(rabbit_params)

    respond_to do |format|
      if @rabbit.save
        format.html { redirect_to cage_path(@rabbit.cage), notice: 'Coniglio creato con successo.' }
        format.json { render :show, status: :created, location: @rabbit }
      else
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

  def new_birth
  end

  def birth
    @rabbit.giving_birth params[:size].to_i, params[:birth_date]

    respond_to do |format|
      format.html { redirect_to cage_path(@rabbit.cage)}
    end
  end

  def edit_notes
  end

  def new_conception
    @conceptioners = RaceRabbit.where(container_id: current_user.farms.first.cages.pluck(:id))
  end

  def conception
    conceptioner    = Rabbit.find_by(id: params[:conceptioner_id])
    conceptioned_on = Date.new(params["conceptioned_on(1i)"].to_i, params["conceptioned_on(2i)"].to_i, params["conceptioned_on(3i)"].to_i)
    logger.info { "conceptioned_on #{conceptioned_on}" }
    @rabbit.make_conception conceptioner, conceptioned_on

    respond_to do |format|
      format.html { redirect_to rabbit_path(@rabbit)}
    end
  end

  def new_move
    @fattening_cages
    @motherhood_cages
    @weaning_cages = current_user.farms.first.cages.weaning
    @race_cages
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
