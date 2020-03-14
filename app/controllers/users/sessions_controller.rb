# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json 
  
  private


  def respond_with(resource, _opts={})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
