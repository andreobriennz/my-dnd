class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by('username = ? or email = ?', params[:username], params[:username])

        if @user.present?&& @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Logged in"
        else
            @user = User.new(username: params[:username])
            @user.errors.add(:base, "Invalid username or password")
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end
