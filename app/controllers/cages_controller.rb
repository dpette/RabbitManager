class CagesController < ApplicationController
  before_filter :authenticate_user!#, except: [:index]

  before_action :set_cage, only: [:show, :edit, :update, :destroy, :move, :move_for_group]


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
        format.html { redirect_to @cage, notice: 'La gabbia è stata aggiornata con successo' }
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
      format.html { redirect_to cages_url, notice: 'La gabbia è stata distrutta con successo' }
      format.json { head :no_content }
    end
  end

  def available_for_group
    @rabbits = Rabbit.where(id: params[:rabbits_ids])
    @cage    = @rabbits.first.cage
    set_available_cages @rabbits
  end

  def available
    @rabbit = Rabbit.find(params[:rabbit_id])
    @cage   = @rabbit.cage

    set_available_cages @rabbit
  end


  def move
    @rabbit = Rabbit.find(params[:rabbit_id])

    if @cage.move @rabbit
      redirect_to cage_path(@cage), notice: "Coniglio spostato con successo"
    else
      set_available_cages @rabbit
      flash[:error] = @rabbit.errors.full_messages.to_sentence
      render :available
    end
  end

  def move_for_group
    @rabbits = Rabbit.where(id: JSON.parse(params[:rabbits_ids]))
    last_rabbit = nil
    move_result = true

    @rabbits.each do |rabbit|
      last_rabbit   = rabbit
      move_result   = @cage.move(last_rabbit)
      break if !move_result
    end

    if move_result
      redirect_to cage_path(@cage), notice: "Conigli spostati con successo"
    else
      set_available_cages @rabbits
      flash[:error] = last_rabbit.errors.full_messages.to_sentence
      render :available_for_group
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

    # def set_farm
    #   if current_user.farms.size > 1
    #     @farm = current_user.farms.find(params[:farm_id])
    #   else
    #     @farm = current_user.farms.first
    #   end
    # end

    def set_cage_type
      @cage_type = class_instance_name_by_controller
    end

  protected

    def set_available_cages rabbits
      rabbits = [rabbits] if rabbits.kind_of? Rabbit
      rabbits.each do |rabbit|
        rabbit.can_become_classes.each do |can_become_class|
          # wanna_be_rabbit = @rabbit.becomes(can_become_class)

          puts ("can_become_class => #{can_become_class}")

          cages = can_become_class.allowed_cage_type.where(farm_id: @farm.id)
          cages = cages.where.not(id: rabbit.container_id) if rabbit.container_type == "Cage"

          instance_variable_set(
            "@#{can_become_class.allowed_cage_type.model_name.plural}",
            cages
          )
        end
      end
    end


end
