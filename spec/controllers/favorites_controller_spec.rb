 require 'rails_helper'
 
 describe FavoritesController do
 
  #include TestFactories
  include Devise::TestHelpers

  # replaced associated_post and authenticated_user for FG
  before do 
    @post = create(:post)
    @user = create(:user)
    sign_in @user
   end

   describe '#create' do
     it "creates a favorite for the current user and specified post" do
       expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)

       post :create, { post_id: @post.id, topic_id: @post.topic.id }

       expect( @user.favorites.find_by_post_id(@post.id).class ).to eq(Favorite)
     end
   end

   describe '#destroy' do
     it "destroys the favorite for the current user and post" do
       favorite = @user.favorites.where(post: @post).create
       expect( @user.favorites.find_by_post_id(@post.id).class ).to eq(Favorite)

       delete :destroy, { post_id: @post.id, topic_id: @post.topic.id, id: favorite.id }

       expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)
     end
   end
end