class PregnanciesController < ApplicationController
  before_action :set_pregnancy, only: [:show, :edit, :update, :destroy]
  before_action :set_rabbit, only: [:show, :edit, :new, :index, :destroy, :update]
  before_action :set_cage, only: [:show, :edit, :new, :index, :destroy, :update]


  # GET /pregnancies
  # GET /pregnancies.json
  def index
    @pregnancies = @rabbit.pregnancies
  end

  # GET /pregnancies/1
  # GET /pregnancies/1.json
  def show
  end

  # GET /pregnancies/new
  def new
    @pregnancy = @rabbit.pregnancies.new(starting_at: Date.today)
  end

  # GET /pregnancies/1/edit
  def edit
    @fields = params[:fields]
  end

  # POST /pregnancies
  # POST /pregnancies.json
  def create
    @pregnancy = Pregnancy.new(pregnancy_params)
    @rabbit    = @pregnancy.rabbit
    @cage      = @rabbit.cage

    respond_to do |format|
      if @pregnancy.save
        format.html { redirect_to rabbit_pregnancies_path(@rabbit), notice: 'Inizio gravidanza registrato' }
        format.json { render :show, status: :created, location: @pregnancy }
      else
        format.html { render :new }
        format.json { render json: @pregnancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pregnancies/1
  # PATCH/PUT /pregnancies/1.json
  def update
    respond_to do |format|
      puts "pregnancy_params => #{pregnancy_params}"
      if @pregnancy.update(pregnancy_params)
        format.html { redirect_to rabbit_pregnancies_path(@rabbit), notice: 'Gravidanza aggiornata con successo.' }
        format.json { render :show, status: :ok, location: @pregnancy }
      else
        format.html { render :edit }
        format.json { render json: @pregnancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pregnancies/1
  # DELETE /pregnancies/1.json
  def destroy
    @pregnancy.destroy
    respond_to do |format|
      format.html { redirect_to rabbit_pregnancies_path(@rabbit), notice: 'Gravidanza rimossa con successo' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pregnancy
      @pregnancy = Pregnancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pregnancy_params
      params.require(:pregnancy).permit(:starting_at, :ending_at, :rabbit_id, :rabbits_size)
    end

    def set_rabbit
      if @pregnancy
        @rabbit = @pregnancy.rabbit
      else
        @rabbit = Rabbit.find(params[:rabbit_id])
      end
    end

    def set_cage
      @cage = @rabbit.cage
    end

end
