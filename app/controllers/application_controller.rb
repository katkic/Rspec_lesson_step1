class ApplicationController < ActionController::Base
  # herokuのBasic認証
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  before_action :login_required
  include SessionsHelper

  # 独自の例外処理
  class Forbidden < StandardError; end
  rescue_from Forbidden, with: :rescue_forbidden

  private

  def login_required
    redirect_to root_path, notice: 'ログインしてください' unless logged_in?
  end

  def rescue_forbidden(exception)
    render 'errors/forbidden', status: 403, layout: 'error', formats: [:html]
  end
end
