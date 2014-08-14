class VotesController < ApplicationController
  before_filter :setup

  def up_vote
    update_vote(1)

    # no flash message, just want it to "happen"
    redirect_to :back
  end

  def down_vote
    update_vote(-1)

    # no flash message, just want it to "happen"
    redirect_to :back
  end

  private

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote # if it exists, update it
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else # create it
      @vote = current_user.votes.build(value: new_value, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end

end

# the directions here were not making sense at all, so I used the sample file. above is the sample and below is part of mine in process


#class VotesController < ApplicationController
 #  before_action :load_post_and_vote

 # def up_vote
 #   @post = Post.find(params[:post_id])

 #   @vote = @post.votes.where(user_id: current_user.id).first

 #   if @vote
 #     authorize @vote, :update?
 #    @vote.update_attribute(:value, 1)
 #   else
 #      @vote = current_user.votes.build(value: new_value, post: @post)
 #      authorize @vote, :create?
 #      @vote.save
 #   end

  #  # http://apidock.com/rails/ActionController/Base/redirect_to
  #  redirect_to :back
  #end

 # private

 # def load_post_and_vote
    # extract into this method the definition o f@post and @topic
 # end

 # def update_vote!(new_value)

    # Extract vote updating/creating logic here.
    # This method has access to @vote, because of the before_action
 # end
# end