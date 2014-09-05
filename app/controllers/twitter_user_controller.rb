class TwitterUserController < ApplicationController
  def show
    tweets = TwitterUser.new(params[:twitter_handle]).recent_tweets
    render :json => tweets
  end
end
