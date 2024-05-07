class ApplicationController < ActionController::Base
  def default_url_options(options={})
    options.merge(protocol: :https)
  end 
end
