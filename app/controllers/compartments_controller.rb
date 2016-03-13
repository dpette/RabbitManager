class CompartmentsController < ApplicationController
  before_action :set_compartment, only: [:show, :edit, :update, :destroy, :move]

  # GET /compartments
  # GET /compartments.json
  def index
    @compartments = Compartment.all
  end

  # GET /compartments/1
  # GET /compartments/1.json
  def show
  end

  # GET /compartments/new
  def new
    @compartment = Compartment.new
  end

  # GET /compartments/1/edit
  def edit
  end

  def available
    @cage         = Cage.find(params[:cage_id])
    @rabbit       = Rabbit.find(params[:rabbit_id])
    @compartments = @cage.compartments
  end

  def move
    @rabbit = Rabbit.find(params[:rabbit_id])
    @cage   = Cage.find(params[:cage_id])

    if @compartment.move @rabbit
      redirect_to cage_path(@cage), notice: "Coniglio spostato con successo"
    else
      @compartments = @cage.compartments
      flash[:error] = @rabbit.errors.full_messages.to_sentence
      render :available
    end
  end

  # POST /compartments
  # POST /compartments.json
  def create
    @compartment = Compartment.new(compartment_params)

    respond_to do |format|
      if @compartment.save
        format.html { redirect_to @compartment, notice: 'Compartment was successfully created.' }
        format.json { render :show, status: :created, location: @compartment }
      else
        format.html { render :new }
        format.json { render json: @compartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compartments/1
  # PATCH/PUT /compartments/1.json
  def update
    respond_to do |format|
      if @compartment.update(compartment_params)
        format.html { redirect_to @compartment, notice: 'Compartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @compartment }
      else
        format.html { render :edit }
        format.json { render json: @compartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compartments/1
  # DELETE /compartments/1.json
  def destroy
    @compartment.destroy
    respond_to do |format|
      format.html { redirect_to compartments_url, notice: 'Compartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compartment
      @compartment = Compartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compartment_params
      params[:compartment]
    end
end
