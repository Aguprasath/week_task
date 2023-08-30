class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: -> { request.format.json? }
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
end
