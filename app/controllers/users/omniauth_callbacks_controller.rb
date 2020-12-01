# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github

  def github
    redirect_to new_user_registration_url
  end

  def failure
    redirect_to new_user_registration_url
  end
end
