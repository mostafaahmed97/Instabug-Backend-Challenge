class ApplicationsController < ApplicationController

  def index
    render json: {Hello: world}
  end

end