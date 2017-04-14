class Account::PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end


  def destroy
    @post.destroy
    redirect_to account_posts_path, alert: "Post deleted"
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "Group deleted"
  end


  def edit
    @post = Post.find(params[:id])
  end




      private

      def find_post_and_check_permission
        @group = Post.find(params[:id])

        if current_user != @post.user
          redirect_to root_path, alert: "You have no permission."
        end
      end

      def group_params
        params.require(:group).permit(:title, :description)
      end

      def post_params
        params.require(:post).permit(:description)
      end



end
