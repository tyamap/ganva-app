# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  experience      :string
#  frequency       :string
#  introduction    :string
#  level           :string
#  name            :string           not null
#  password_digest :string           not null
#  status          :string           default("stable"), not null
#  uid             :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  gym_id          :bigint
#
# Indexes
#
#  index_users_on_LOWER_email  (lower((email)::text)) UNIQUE
#  index_users_on_LOWER_uid    (lower((uid)::text)) UNIQUE
#  index_users_on_gym_id       (gym_id)
#
# Foreign Keys
#
#  fk_rails_...  (gym_id => gyms.id)
#
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

  # mygym
  belongs_to :gym, optional: true

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

  # ユーザーのアクティビティフィードを返す
  def feed
    following_ids = 'SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id'
    Activity.where("user_id IN (#{following_ids})
                    OR user_id = :user_id", user_id: id)
  end
end
