class RaceCagesController < CagesController

  # GET /cages/1
  # GET /cages/1.json
  def show
  	if @cage.rabbit
    	redirect_to rabbit_path(@cage.rabbit)
  	else
    	render "#{@cage.model_name.route_key}/show"
  	end
  end

end