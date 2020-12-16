# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_one_attached :avatar

  has_many :following_relationships, class_name: 'UserRelationship', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_many :followed_relationships, class_name: 'UserRelationship', foreign_key: 'followed_id', inverse_of: :followed, dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def following?(target_user)
    following_relationships.exists?(followed_id: target_user.id)
  end

  def follow(target_user)
    return if self == target_user || following?(target_user)

    following_relationships.create(followed: target_user)
  end

  def unfollow(target_user)
    return unless following?(target_user)

    following_relationships.find_by(followed_id: target_user.id).destroy
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
