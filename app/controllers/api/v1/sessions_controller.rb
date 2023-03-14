# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(session_params[:email])
    if user&.valid_password?(session_params[:password])
      render_api_success(serializer, user)
    else
      render_api_error('Invalid email or password', 401)
    end
  end

  private

  def serializer
    SessionsSerializer
  end

  def session_params
    params.except(:format).permit(:email, :password)
  end
end
