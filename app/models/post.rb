class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :qmemo, presence: true, length: { maximum: 500 }
  validates :amemo, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 255 }
  #カテゴリはどう入れるのだろうか。
  
  has_many :coomments, dependent: :destroy
end
