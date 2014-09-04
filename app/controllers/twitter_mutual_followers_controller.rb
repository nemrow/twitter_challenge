class TwitterMutualFollowersController < ApplicationController
  def show
    render :json => TwitterDataPresenter.new(params[:twitter_handle_main]).mutual_followers_as_json(params[:twitter_handle_for_intersection])
  end
end
