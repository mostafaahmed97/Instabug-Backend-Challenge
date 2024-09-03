class ApplicationsController < ApplicationController

  # Hook that defines that find_app runs before the listed methods
  before_action :find_application, only: [:show, :update, :destroy]

  def index
    applications = Application.all
    render json: applications.as_json(except: [:id])
  end

  def show
    if @application
      render json: @application.as_json(except: [:id])
    else
      render json: {error: "No such application"}, status: :not_found
    end
  end

  def create
    name = params[:name]
    application = Application.new(name: name)

    if application.save
      render json: application.as_json(except: [:id])
    else
      render json: application.errors.as_json, status: :unprocessable_entity
    end
  end

  def destroy
    if @application.destroy
      render body: nil, status: :no_content
    else
      render json: { error: "Deletion failed" }, status: :unprocessable_entity
    end
  end

  def update
    name = params[:name]

    if @application.update(name: name)
      render json: @application.as_json(except: [:id])
    else
      render json: @application.errors.as_json, status: :unprocessable_entity
    end
  end

  private
  # Private function, will run before routes that
  # need to fetch an application by token and set the result
  # as a class variable
  def find_application
    @application = Application.find_by(token: params[:token])
  end

end