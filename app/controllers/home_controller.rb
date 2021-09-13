class HomeController < ApplicationController
  def index    
    render json: permited_params[:id]
  end

  def test
    render json:'olá'
  end

  private

  def permited_params
    params.permit(:id)
  end
end
