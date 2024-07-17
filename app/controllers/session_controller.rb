class SessionController < ApplicationController
    def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
          @session = @user.sessions.create
          cookies.permanent[:twitter_session_token] = @session.token
          render json: { message: "Logged in successfully" }, status: :ok
        else
          render json: { message: "Invalid username or password" }, status: :unauthorized
      end
    end
    def authenticated
      @session = Session.find_by(token: cookies[:twitter_session_token])
       if @session
       render json: { authenticated: true }, status: :ok
        else
          render json: { authenticated: false }, status: :unauthorized
      end
    end
    def destroy
        @session = Session.find_by(token: cookies[:twitter_session_token])
        if @session
          @session.destroy
          cookies.delete(:twitter_session_token)
          render json: { message: "Logged out successfully" }, status: :ok
        else
          render json:  status: :unauthorized
        end
      end
end

