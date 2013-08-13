class ApplicationController < ActionController::Base
  protect_from_forgery

  	def comingsoon
    	render :template => '../../public/index.html', :layout => false, :status => 200
  	end
end
