class User < ApplicationRecord
  include PasswordHolder
  include EmailHolder

  validates :name, presence: true, length: { maximum: 50 }
  validates :uid, presence: true, length: { maximum: 15 }, 

  # 能動的関係 つまりフォロー中ユーザーのこと
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # 受動的関係 つまりフォロワーのこと
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  #  following という名前で followed_id リストを扱う
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
