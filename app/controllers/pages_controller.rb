# frozen_string_literal: true

# Controller for default available pages.
class PagesController < ApplicationController
  # no authorization needed here for these pages, as they are available to those not logged in
  skip_authorization_check

  # GET '/'
  # the default website landing page
  def home
    @current_nav_identifier = :home
  end

  # dummy method for guest authentication
  def guest_page; end
end
