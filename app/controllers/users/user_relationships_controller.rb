# frozen_string_literal: true

class Users::UserRelationshipsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).following.order(:id).page(params[:page])
  end

  def create
    target_user = User.find(params[:user_relationship][:followed_id])
    current_user.follow(target_user)
    redirect_to target_user
  end

  def destroy
    target_user = UserRelationship.find(params[:id]).followed
    current_user.unfollow(target_user)
    redirect_to target_user
  end
end
