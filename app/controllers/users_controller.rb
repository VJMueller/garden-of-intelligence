class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all 
        authorize @users
    end

    def show
        @user = User.find(params[:id])
        authorize @user
    end

    def edit
        @user = User.find(params[:id])
        authorize @user
    end

    def update
        @user = User.find(params[:id])
        authorize @user
        if @user.update(user_params)
            redirect_to @user
          else
            render :edit, status: :unprocessable_entity
          end
    end

    def destroy
        @user = User.find(params[:id])
        authorize @user
        @user.destroy!
        redirect_to users_path, status: :see_other
    end

    private

    def user_params
        params.require(:user).permit(:role)
    end
end
