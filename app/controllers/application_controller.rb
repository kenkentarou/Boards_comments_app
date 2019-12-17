class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  unless Rails.env.development?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def render_500(e)
    ExceptionNotifier.notify_exception(e, env: request.env, data: {message: "your error message"})
  end

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end


  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインが必要です'
  end
end
