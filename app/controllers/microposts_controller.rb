class MicropostsController < ApplicationController
	before_filter :authenticate
	before_filter :authorized_user, :only => :destroy
	
	def create
		#@micropost = current_user.microposts.build(params[:micropost])
		@micropost = Micropost.new(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			#redirect_to pages_path
			redirect_to :back
		else
			render 'pages/home'
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_to pages_path
	end

	private
		def authorized_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to pages_path if @micropost.nil?
		end

end
