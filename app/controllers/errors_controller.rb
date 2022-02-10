class ErrorsController < ApplicationController

  skip_before_action :ie_warning
  skip_before_action :verify_authenticity_token, only: [:error_422]
  skip_authorization_check

  def error_403
  end

  def error_404
  end

  def error_422
  end

  def error_500
    begin
      render
    rescue
      render layout: 'plain_error'
    end
  end

  def ie_warning
  end
end
