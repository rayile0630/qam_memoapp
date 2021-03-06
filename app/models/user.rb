class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { maximum: 255 }                
    validates :introduction, presence: true, length: { maximum: 500 }   #改行用のformatいるかも？後で確認             
    has_secure_password
    
    has_many :posts, dependent: :destroy
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    has_many :favorites, dependent: :destroy
    has_many :favposts, through: :favorites, source: :post, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    def follow(other_user)
      unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(post)
     unless self == post
       favorites.find_or_create_by(post_id: post.id)
     end
  end
  
  def unlike(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def favpost?(post)
    self.favposts.include?(post)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
end
