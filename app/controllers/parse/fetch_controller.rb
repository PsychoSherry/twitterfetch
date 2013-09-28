class Parse::FetchController < ApplicationController
	def user
		@user = Twitteruser.where(:handle => params[:user].to_s)

		if @user.count == 0
			parsethatshit params[:user]
		else
	        @user = @user.first
	        if @user.completed
	        	render json:{
					status: 'completed'
				}
	        elsif @user.working
	        	busyshit
	        else
	        	@user.working = true
	        	@user.save
	        	parsethatshit params[:user]
	        end	
	    end		
	end

	def useragain
		@user = Twitteruser.where(:handle => params[:user].to_s)

		if @user.count == 0
			parsethatshit params[:user]
		else
	        @user = @user.first
        	parsethatshit params[:user]
	    end		
	end

	def tweets
		@user = Twitteruser.where(:handle => params[:user].to_s)

		if @user.count == 0
			render json:{
				status: 'not found'
			}
		else
	        @user = @user.first

			timefrom = Time.parse(params[:from].to_s)
			timeto   = Time.parse(params[:to].to_s)

			res = @user.tweets.where(:created_at.gte => timefrom, :created_at.lte => timeto)

			render json: res.to_json
	    end	

	end


	def parsethatshit user
		Twitteruser.delay.parseuser user
		render json:{
					status: 'parsing user data'
				}
	end

	def busyshit
		render json: {
			status: 'busy'
		}
	end
end
