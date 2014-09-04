class TwitterDataPresenter
  def initialize(twitter_handle)
    @twitter_user = TwitterUser.new(twitter_handle)
  end

  def recent_tweets_as_json
    {
      :name => @twitter_user.twitter_handle,
      :tweets => @twitter_user.recent_tweets
    }
  end

  def mutual_followers_as_json(twitter_handle_for_intersection)
    {
      :twitter_handles => [
        @twitter_user.twitter_handle,
        twitter_handle_for_intersection
      ],
      :mutual_followers => @twitter_user.mutual_followers(twitter_handle_for_intersection)
    }
  end
end
