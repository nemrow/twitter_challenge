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
    get_mutual_followers_data(users_follower_ids, follower_ids_to_intersect)
  end

  private
    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["TWITTER_KEY"]
        config.consumer_secret = ENV["TWITTER_SECRET"]
      end
    end

    def get_mutual_followers_data(users_follower_ids, follower_ids_to_intersect)
      mutual_followers_ids = users_follower_ids.to_a & follower_ids_to_intersect.to_a
      get_users_by_twitter_ids(mutual_followers_ids)
    end

    def get_users_by_twitter_ids(twitter_ids_array)
      client.users(twitter_ids_array).map do |current_follower|
        current_follower.attrs.merge(:profile_image_url => edit_image_url(current_follower.profile_image_url))
      end
    end

    def edit_image_url(image_url)
      image_url.to_s.gsub("_normal", "")
    end

    def get_tweets(twitter_handle, quantity)
      client.user_timeline(twitter_handle, {:count => quantity})
    end

    def get_follower_ids(twitter_handle)
      client.follower_ids(twitter_handle)
    end
end
