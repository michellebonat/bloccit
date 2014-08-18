class FavoritesController < ApplicationController
   def create
     @post = Post.find(params[:post_id])
     favorite = current_user.favorites.build(post: @post)
 
     if favorite.save
       # Add code to generate a success flash and redirect to @post
       # Remember the path shortcut: [@post.topic, @post]
       @post.create_favorite
       flash[:notice] = "Your favorite was saved."
       redirect_to [@topic, @post]
     else
       # Add code to generate a failure flash and redirect to @post
       flash[:error] = "There was an error saving your favorite. Please try again."
       redirect_to [@post]
     end
   end

   def destroy
   # Get the post from the params
   # Find the current user's favorite with the ID in the params
 
   if favorite.destroy
     # Flash success and redirect to @post
   else
     # Flash error and redirect to @post
   end
 end
end
# this is the destroy from posts controller
#def destroy
 #    @topic = Topic.find(params[:topic_id])
  #   @post = Post.find(params[:id])
  #  title = @post.title
  #   authorize @post
 
  #   if @post.destroy
  #     flash[:notice] = "\"#{title}\" was deleted successfully."
  #     redirect_to @topic
  #   else
  #     flash[:error] = "There was an error deleting the post."
  #     render :show
  #   end
 #  end


 