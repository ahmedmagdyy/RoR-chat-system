# frozen_string_literal: true

class AppController < ApplicationController
  def create
    unless params[:name].present?
      json
    end
    @application = App.new
  end

  private

  # Using a private method to encapsulate the permissible parameters
  # is just a good pattern since you'll be able to reuse the same
  # permit list between create and update. Also, you can specialize
  # this method with per-user checking of permissible attributes.
  def app_params
    params.require(:app).permit(:name)
  end

  def generate_random_token
    SecureRandom.uuid
  end
end
