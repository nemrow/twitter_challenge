class TwitterMutualFollowersController < ApplicationController
  def show
    presenter = TwitterDataPresenter.new(params[:twitter_handle_main])
    render :json => presenter.mutual_followers_as_json(params[:twitter_handle_for_intersection])
  end
end
