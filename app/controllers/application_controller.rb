# frozen_string_literal: true

class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|

    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.js { render status: :forbidden }
      format.json { render json: exception.message, status: :forbidden }
    end
  end

  check_authorization unless: :devise_controller?

  private

  def current_ability
    @current_ability ||= Ability.new(current_user || current_resource_owner)
  end
end
