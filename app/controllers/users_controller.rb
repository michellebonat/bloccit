class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
    @comments = @user.comments
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      redirect_to edit_user_registration_path
    end
  end

   def destroy
     @topic = Topic.find(params[:id])
     name = @topic.name

     authorize @topic
     if @topic.destroy
       flash[:notice] = "\"#{name}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "There was an error deleting the topic."
       render :show
     end
   end 
 
   private
 
   def user_params
      params.require(:user).permit(:name, :avatar, :avatar_cache, :email_favorites)
   end
 end