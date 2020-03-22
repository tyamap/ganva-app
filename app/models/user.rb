class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }

  include UserIdHolder
  # TODO: 最小文字数指定するとuser情報編集時になぜかエラー
  # include PasswordHolder
  include EmailHolder

  # rerationship
  has_many :active_relationships,  class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # activity
  has_many :activities, dependent: :destroy, autosave: true

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
