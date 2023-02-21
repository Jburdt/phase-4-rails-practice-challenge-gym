class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #POST /memeberships
  def create
    @membership = Membership.create!(membership_params)
    render json: @membership, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  private

  #membership params
  def membership_params
    params.permit(:gym_id, :client_id, :charge)
  end
  
  #Not found Response
  def render_not_found_response
    render json: { error: "Membership not found!" }, status: :not_found 
  end

end
