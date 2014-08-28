class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

# this is the create method I had before the exersice told me to replace it in the Create Ajax exercise

 # def create
    # this should create a new comment associated with a post and the current_user who created it
  #  @topic = Topic.find( params[:topic_id] )
  #  @post = @topic.posts.find( params[:post_id] )
  #  @comments = @post.comments

  #  @comment = current_user.comments.build( comment_params )
  #  @comment.post = @post
  #  @new_comment = Comment.new

    # authorize @comment

  #  if @comment.save
  #    flash[:notice] = "Comment was created."
  #  else
  #    flash[:error] = "There was an error saving the comment. Please try again."
  #  end

  #  respond_with(@comment) do |f|
  #    f.html { redirect_to [@topic, @post] }
  #  end
 # end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

# this is the comment_params I had before the Create Ajax had me update it I did not have as private
#  def comment_params
#    params.require(:comment).permit(
#      :body,
#      :post_id
#    )
#  end
#end
