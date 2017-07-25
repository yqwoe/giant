class Api::V1::PlatesController < ActionController::API
  def index
  end

  def create
    @plate = Plate.new
    @plate.licensed_id = params[:licensed_id]
    @plate.avatar      = params[:avatar]
    if @plate.save
      render plain: 'ok'
    end
  end
end
