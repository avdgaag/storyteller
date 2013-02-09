class ApplicationController < ActionController::Base
  extend Exposure
  protect_from_forgery
end
