class UserController < ApplicationController	
before_action :authenticate_user!
 def users
 	@users = User.all
 	@friends = current_user.friends.all
 end

 def show
 	user = User.find_by(id:current_user.id)
 	@audios = user.audios.all
 end

 def friend_index
 	@friends = Friend.where(user_id:current_user.id) 
 	@users = User.all 
 end

 def friend_create
 	user = User.find_by(id:current_user.id)
 	friend = Friend.new
 	friend.friend_id = params[:id]
 	user.friends << friend
    user.save
    redirect_to friend_show_user_path(params[:id])
 end

 def friend_show 	 	
    @user = User.find_by(:id => params[:id]) 
    	@audios = @user.audios.all
 end

 def search
 	@query = User.search do
        fulltext params[:search]
    end
    @friends = Friend.where(user_id:current_user.id)
    @users = @query.results
 end 

end
