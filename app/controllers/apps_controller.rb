# frozen_string_literal: true

class AppsController < ApplicationController
  before_action :set_app, only: %i[show update]

  # GET /app
  def index
    @apps = App.all.includes(:chats)
    render json: @apps, include: ['chats']
  end

  # GET /app/:token
  def show
    if @app
      render json: @app, include: ['chats']
    else
      render json: { message: 'App Not Found' }, status: :not_found
    end
  end

  # POST /app
  def create
    json_response('Missing Parameter name', :bad_request) unless params[:name].present?
    @app = App.create(app_params)
    @app.token = generate_random_token
    if @app.save
      RedisCache.redis.set(@app.token, 0)
      render json: @app
    else
      render json: { message: 'Failed Creating App' }, status: :not_found
    end
  end

  # PUT /app/:token
  def update
    render json: { message: 'Failed Creating App' }, status: :not_found if @app.nil?
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
