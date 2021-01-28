# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @other_user = create(:user)
  end

  test '#following?: 対象のユーザーをフォローしているかを返すこと' do
    assert_not @user.following?(@other_user)
    @user.active_relationships.create(follower_id: @other_user.id)
    assert @user.following?(@other_user)
  end

  test '#followed_by?: 対象のユーザーにフォローされているかを返すこと' do
    assert_not @user.followed_by?(@other_user)
    @other_user.active_relationships.create(follower_id: @user.id)
    assert @user.followed_by?(@other_user)
  end

  test '#follow: 他のユーザーをフォローできること' do
    assert_not @user.following?(@other_user)
    @user.follow(@other_user)
    assert @user.following?(@other_user)
  end

  test '#unfollow: 他のユーザーのフォローを外せること' do
    @user.follow(@other_user)
    assert @user.following?(@other_user)

    @user.unfollow(@other_user)
    assert_not @user.following?(@other_user)
  end

  test '#name_or_email: 名前があれば名前を、なければメールアドレスを返すこと' do
    user = create(:user, name: '', email: 'test@example.com')
    assert_equal 'test@example.com', user.name_or_email

    user.name = 'test'
    assert_equal 'test', user.name_or_email
  end
end
