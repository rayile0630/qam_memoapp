class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :qmemo, presence: true, length: { maximum: 1000 }
  validates :amemo, presence: true, length: { maximum: 1000 }
  validates :address, presence: true, length: { maximum: 255 }
  
  enum comprehension:{
   理解: 1,
   うーん: 2,
   さっぱり: 3,
  }
  
  def self.search(search)
      return Post.all unless search
      Post.where(['title LIKE ?', "%#{search}%"])
  end
  
  def self.create_all_ranks #postのクラスからデータを取ってくる処理なのでクラスメソッド！
    Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
    
  
  has_many :comments, dependent: :destroy
end
