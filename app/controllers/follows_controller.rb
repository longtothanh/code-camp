class FollowsController < ApplicationController
    before_action :authenticate_user!

    def create
        user_to_follow = User.find(params[:id])
        if user_to_follow != current_user
            current_user.following << user_to_follow unless current_user.following.include?(user_to_follow)
            @notifications = current_user.create_notification('follow', "Bạn đã theo dõi #{user_to_follow.email}.")
            flash[:notice] = "Following user successfully! #{user_to_follow.email}"
        else
            redirect_to users_path, alert: "You cannot follow yourself."
        end
        respond_to do |format|
            format.html { redirect_to users_path(user_to_follow) }
            format.js
        end
    end

  def destroy
    user_to_unfollow = User.find(params[:id])
    current_user.following.delete(user_to_unfollow)
    @notifications = current_user.create_notification('unfollow', "Bạn đã hủy theo dõi #{user_to_unfollow.email}.")
    flash[:alert] = "Unfollowing #{user_to_unfollow.email} successfully!"
    respond_to do |format|
        format.html { redirect_to users_path(user_to_unfollow) }
        format.js
    end
  end
end
