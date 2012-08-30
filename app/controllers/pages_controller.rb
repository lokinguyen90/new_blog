class PagesController <ApplicationController
	#layout "test"
  def home
  	@title="Home page"
  	@micropost = Micropost.new if signed_in?
    #flash[:success]+="here"+current_user.inspect+ "\n"+cookies.signed[:remember_token].inspect+"\n"
  	#render :layout => "layouts/test"
  end
  
  def about
  	@title="About page"
  end

  def help
  	@title="Help"
  end
end