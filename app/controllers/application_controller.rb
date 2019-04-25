# frozen_string_literal: true

class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exceotion|
    redirect_to root_path, alert: exceotion.message
  end

  check_authorization unless: :devise_controller?
end
