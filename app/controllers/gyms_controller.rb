class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /gyms
  def index
    @gyms = Gym.all 
    render json: @gyms 
  end

  # GET /gyms/:id
  def show 
    @gym = find_gym 
    render json: @gym 
  end

  # PATCH /gyms/:id
  def update
    @gym = find_gym
    @gym.update!(gym_params)
    render json: @gym 
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end
  
  #DESTROY /gyms/:id
  def destroy
    @gym = find_gym
    @gym.destroy
    head :no_content
  end

  private

   #Not found Response
   def render_not_found_response
    render json: { error: "Gym not found!" }, status: :not_found 
  end

  # Finds gym by id
  def find_gym
    Gym.find(params[:id])
  end

  # Gym params
  def gym_params
    params.permit(:name, :address)
  end

end
