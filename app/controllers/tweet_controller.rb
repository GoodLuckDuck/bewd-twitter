class TweetsController < ApplicationController
    before_action :authenticate_user, only: [:create, :destroy]
  
    def create
      @tweet = current_user.tweets.create(tweet_params)
      if @tweet.save
        render json: @tweet, status: :created
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        render json: status: :ok
      else
        render json: status: :unauthorized
      end
    end
  
    def index
      @tweets = Tweet.all
      render json: @tweets, status: :ok
    end
  
    def index_by_user
      @user = User.find_by(username: params[:username])
      if @user
        @tweets = @user.tweets
        render json: @tweets, status: :ok
      else
        render json: status: :not_found
      end
    end
  
    private
  
    def tweet_params
      params.require(:tweet).permit(:message)
    end
  
    def authenticate_user
      @session = Session.find_by(token: cookies[:twitter_session_token])
      if @session
        @current_user = @session.user
      else
        render json: status: :unauthorized
      end
    end
  
    def current_user
      @current_user
    end
  end