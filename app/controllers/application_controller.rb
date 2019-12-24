class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  unless Rails.env.development?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def render_500(e)
    if e
      ExceptionNotifier.notify_exception(e, env: request.env, data: {message: 'your error message'})
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
    end
    render file: 'public/500', status: 500, layout: false
  end

  def render_404
    render file: 'public/404', status: 404, layout: false
  end

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインが必要です'
  end
end
