class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  # updating here for scopes withing scope at bottom of scopes exercise
  #scope :visible_to, -> (user) { user ? all : where(public: true) }
  #scope :visible_to, -> (user) { user ? all : where(public: true), user ? current_user : where(public: false) }
  scope :private, -> { where(public: false) }
  scope :public, -> { where(public: true) }
  scope :visible_to, -> (user) { user ? all : where(public: true) }  
end

