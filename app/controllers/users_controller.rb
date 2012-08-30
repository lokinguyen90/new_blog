class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update , :show]
  before_filter :correct_user, :only => [:edit, :update]

  def index
  	@users = User.all
  	@title = "All users"
  end

  def new
  	@title="Sign Up"
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts
    @micropost = Micropost.new if signed_in?
  	@title = @user.name
  end

  def create
	@user = User.new(params[:user])
	if @user.save
		sign_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		@title = "Sign up"
		render 'new'
	end
  end

  def edit
  	@user = User.find(params[:id])
  	@title = "Edit User"
  end

  def update
  	@user = User.find(params[:id])

    user_data = params[:user]
    #flash[:success] ="Before: "+current_user.inspect+ "\n"+remember_token.inspect+"\n"
   #edit invidual information
    respond_to do |format|
      if @user.update_attributes(params[:user])
        sign_in @user
        #flash[:success] +="after: "+current_user.inspect+ "\n"+remember_token.inspect+"\n"
        #redirect_to root_path
        format.html { redirect_to(@user, :notice => 'User profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  #def destroy
  #	@user = User.find(params[:id])
  #	if current_user.admin?
  #		@user.destroy
  #		flash[:success] = "User destroyed."
  #		redirect_to users_path
  #	else
  #		flash[:error] = "You are not allowed to do this."
  #		redirect_to pages_path
  # end
  #end

  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User destroyed."
	redirect_to users_path
  end

  def upload
    #@user = User.find(params[:user_id])
    user_data = params[:user]
    @user = User.find(user_data['user_id'])
    name =  user_data['avatar'].original_filename
    directory = "#{RAILS_ROOT}/public/images/user/"
    # create the file path
    #path = File.join(directory, name)
    path =  directory+@user.id.to_s+ "-" + name
    File.open(path, "wb") { |f| f.write(user_data['avatar'].read) }
    user_data['avatar'] = "/images/user/" + @user.id.to_s + "-" + name
    if @user.update_attributes(user_data)
        @microposts = Micropost.find_all_by_poster_id(@user.id)
        @microposts.each do |micropost|
          micropost.update_attributes({'poster_avatar'=>@user.avatar})
        end
        redirect_to(@user, :notice => 'User avatar was successfully updated.')
    else
     flash[:error] = @user.errors.inspect
     redirect_to pages_path
    end
  end

  private

	def correct_user
		@user = User.find(params[:id])
		redirect_to(pages_path) unless current_user?(@user)
	end

end
