class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  # need to remove this to make progress on Voting, need to add back later
  # mount_uploader :image, ImageUploader

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

   def up_votes
      votes.where(value: 1).count
   end

   def down_votes
    votes.where(value: -1).count
   end

   def points
     votes.sum(:value).to_i
   end

   def update_rank
     age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
     new_rank = points + age
 
     update_attribute(:rank, new_rank)
   end

   # added this in during Mocking with RSPec exercise
   # Who ever created a post, should automatically be set to "voting" it up.
   def create_vote
     user.votes.create(value: 1, post: self)
   end    
  
end