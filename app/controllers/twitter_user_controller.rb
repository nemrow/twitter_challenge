class TwitterUserController < ApplicationController
  def show
    render :json => TwitterDataPresenter.new(params[:twitter_handle]).recent_tweets_as_json
  end
end
