class HomeController < ApplicationController
  def index    
    render json: permited_params[:id]
  end

  private

  def permited_params
    params.permit(:id)
  end
end
