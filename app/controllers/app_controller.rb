# frozen_string_literal: true

class AppController < ApplicationController
  before_action :set_app
  include Response
  include ExceptionHandler
  # attr_accessor :token, :name

  # GET /app
  def index
    @apps = App.all
    # TODO: Use Serializer to predefine output fields
    json_response(@apps)
  end

  # GET /app/:token
  def show
    @app ? json_response(@app) : json_response('App Not Found', :not_found)
  end

  # POST /app
  def create
    json_response('Missing Parameter name', :bad_request) unless params[:name].present?
    @app = App.create(app_params)
    @app.token = generate_random_token
    json_response(@app, :created) if @app.save
  end

  # PUT /app/:token
  def update
    json_response('App Not Found', :not_found) if @app.nil?
    @app.update(app_params)
    head :no_content
  end

  private

  def app_params
    params.permit(:name)
  end

  def set_app
    @app = App.find_by_token(params[:token])
  end

  def generate_random_token
    SecureRandom.uuid
  end
end
