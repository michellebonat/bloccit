 require 'rails_helper'
 
 describe VotesController do 
 
   #include TestFactories
   include Devise::TestHelpers
 
   # replaced authenticated_user and associated_post for FG
   describe '#up_vote' do
     it "adds an up-vote to the post" do
       request.env["HTTP_REFERER"] = '/'
       @user = create(:user)
       @post = create(:post)
       sign_in @user
 
       expect {
         post( :up_vote, post_id: @post.id, topic_id: @post.topic.id )
       }.to change{ @post.up_votes }.by 1
     end
   end
 end