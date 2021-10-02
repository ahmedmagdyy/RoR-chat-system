# frozen_string_literal: true

class AppController < ApplicationController
  include Response
  include ExceptionHandler
  # attr_accessor :token, :name

  # GET /app
  def index
    @apps = App.all
    # TODO: Use Serializer to predefine output fields
    json_response(@apps.as_json(only: %i[token name chat_count created_at updated_at]))
  end

  # GET /app/:token
  def show
    @app = App.find_by_token(params[:token])
    @app ? json_response(@app) : json_response('App Not Found', :not_found)
  end

  # POST /app
  def create
    json_response('Missing Parameter name', :bad_request) unless params[:name].present?
    @app = App.create(app_params)
    @app.token = generate_random_token
    json_response(@app.as_json(only: %i[token name chat_count created_at updated_at]), :created) if @app.save
  end

  # PUT /app/:token
  def update
    @app = App.find_by_token(params[:token])
    json_response('App Not Found', :not_found) if @app.nil?
    @app.update(app_params)
    head :no_content
  end

  private

  # Using a private method to encapsulate the permissible parameters
  # is just a good pattern since you'll be able to reuse the same
  # permit list between create and update. Also, you can specialize
  # this method with per-user checking of permissible attributes.
  def app_params
    params.require(:app).permit(:name)
  end

  # def set_app
  #   @app = App.find_by_token(@app_token)
  # end

  def generate_random_token
    SecureRandom.uuid
  end
end
