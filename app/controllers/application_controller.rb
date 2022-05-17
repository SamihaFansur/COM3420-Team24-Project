# general controller, used for settings and authentication.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :update_headers_to_disable_caching
  before_action :ie_warning
  # ensures user is logged in on every page except the landing page.
  before_action :authenticate_user!, except: [:home]

  # Catch NotFound exceptions and handle them neatly, when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/error_404', status: 404
  end
  rescue_from CanCan::AccessDenied do
    render template: 'errors/error_403', status: 403
  end

  # IE over HTTPS will not download if browser caching is off, so allow browser caching when sending files
  # def send_file(file, opts = {})
  #   response.headers['Cache-Control'] = 'private, proxy-revalidate' # Still prevent proxy caching
  #   response.headers['Pragma'] = 'cache'
  #   response.headers['Expires'] = '0'
  #   super(file, opts)
  # end

  # sets search parameteres for Recipe gem
  def set_search
    @q = Recipe.search(params[:q])
  end

  # method that determines where the user is routed after logging in
  def after_sign_in_path_for(_resource)
    unless current_user.nil?
      if current_user.role == 'admin' # route to users page
        users_path
      elsif current_user.role == 'student' # route to ecfs page
        ecfs_path
      elsif current_user.role == 'module_leader'
        ecfs_path
      elsif current_user.role == 'scrutiny' # route to meetings page
        meetings_path
      elsif current_user.role == 'scrutiny_chair' # route to meetings page
        meetings_path
      else # user must be a guest
        guest_page_path
      end
    end
  end

  private

  def update_headers_to_disable_caching
    response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '-1'
  end

  # handling internet explorer users
  def ie_warning
    if request.user_agent.to_s =~ /MSIE [6-7]/ && request.user_agent.to_s !~ %r{Trident/7.0}
      redirect_to(ie_warning_path)
    end
  end
end
