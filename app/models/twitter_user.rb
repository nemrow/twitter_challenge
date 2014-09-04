class TwitterUser
  attr_accessor :twitter_handle

  def initialize(twitter_handle)
    @twitter_handle = twitter_handle
  end

  def recent_tweets(quantity=20)
    get_tweets(@twitter_handle, quantity)
  end

  def mutual_followers(twitter_handle_for_intersection)
    users_follower_ids = get_follower_ids(@twitter_handle)
    follower_ids_to_intersect = get_follower_ids(twitter_handle_for_intersection)
    mutual_followers = users_follower_ids.to_a & follower_ids_to_intersect.to_a
    client.users(mutual_followers)
  end

  private
    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["TWITTER_KEY"]
        config.consumer_secret = ENV["TWITTER_SECRET"]
      end
    end

    def get_tweets(twitter_handle, quantity)
      client.user_timeline(twitter_handle, {:count => quantity})
    end

    def get_follower_ids(twitter_handle)
      client.follower_ids(twitter_handle)
    end
end
