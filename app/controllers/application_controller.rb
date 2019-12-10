class ApplicationController < ActionController::Base
  # herokuのBasic認証
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  before_action :login_required

  include SessionsHelper

  private

  def login_required
    redirect_to root_path, notice: 'ログインしてください' unless logged_in?
  end
end
