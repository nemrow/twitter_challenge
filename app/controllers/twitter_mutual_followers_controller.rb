class TwitterMutualFollowersController < ApplicationController
  def show
    mutual_followers = TwitterUser.new(params[:twitter_handle_main]).mutual_followers(TwitterUser.new(params[:twitter_handle_for_intersection]))
    render :json => mutual_followers
  end
end
