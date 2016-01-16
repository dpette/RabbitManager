class FatteningsController < ApplicationController
  before_action :set_fattening, only: [:show, :edit, :update, :destroy]

  # GET /fattenings
  # GET /fattenings.json
  def index
    @fattenings = Fattening.all
  end

  # GET /fattenings/1
  # GET /fattenings/1.json
  def show
  end

  # GET /fattenings/new
  def new
    @fattening = Fattening.new
  end

  # GET /fattenings/1/edit
  def edit
  end

  # POST /fattenings
  # POST /fattenings.json
  def create
    @fattening = Fattening.new(fattening_params)

    respond_to do |format|
      if @fattening.save
        format.html { redirect_to @fattening, notice: 'Fattening was successfully created.' }
        format.json { render :show, status: :created, location: @fattening }
      else
        format.html { render :new }
        format.json { render json: @fattening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fattenings/1
  # PATCH/PUT /fattenings/1.json
  def update
    respond_to do |format|
      if @fattening.update(fattening_params)
        format.html { redirect_to @fattening, notice: 'Fattening was successfully updated.' }
        format.json { render :show, status: :ok, location: @fattening }
      else
        format.html { render :edit }
        format.json { render json: @fattening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fattenings/1
  # DELETE /fattenings/1.json
  def destroy
    @fattening.destroy
    respond_to do |format|
      format.html { redirect_to fattenings_url, notice: 'Fattening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fattening
      @fattening = Fattening.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fattening_params
      params[:fattening]
    end
end
