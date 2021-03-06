def new
  @post = Post.new
end

   def create
     @post = Post.new(params.require(:post).permit(:title, :body))
     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
   end

  def edit
  end