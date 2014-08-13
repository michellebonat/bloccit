class CommentsController < ApplicationController
  def create
    # this should create a new comment associated with a post and the current_user who created it
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find( params[:post_id] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def comment_params
    params.require(:comment).permit(
      :body,
      :post_id
    )
  end
end


# this is the create section from the posts controller
# def create
#    @topic = Topic.find(params[:topic_id])
#    @post = current_user.posts.build(post_params)
#    @post.topic = @topic
#    authorize @post

#    if @post.save
#      flash[:notice] = "Post was saved."
#      redirect_to [@topic, @post]
#    else
#      flash[:error] = "There was an error saving the post. Please try again."
#      render :new
#    end