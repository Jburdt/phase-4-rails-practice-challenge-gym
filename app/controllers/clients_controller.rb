class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #INDEX /clients
  def index
    @clients = Client.all 
    render json: @clients
  end
  
  # SHOW /clients/:id
  def show
    @client = find_client
    render json: @client
  end

  # UPDATE /clients/:id
  def update
    @client = find_client
    @client.update!(client_params)
    render json: @client
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  private

    #Not found Response
    def render_not_found_response
      render json: { error: "Client not found!" }, status: :not_found 
    end

    # Finds client by id
    def find_client
      Client.all.find(params[:id])
    end

    #Client params
    def client_params
      params.permit(:name, :age)
    end

end
