class TwitterUser
  attr_accessor :twitter_handle

  def initialize(twitter_handle)
    @twitter_handle = twitter_handle
  end

  def recent_tweets(quantity=20)
    get_tweets(@twitter_handle, quantity)
  end

  def mutual_followers(twitter_handle_for_intersection)
    users_following_ids = get_following_ids(@twitter_handle)
    following_ids_to_intersect = get_following_ids(twitter_handle_for_intersection)
    get_mutual_followings_data(users_following_ids, following_ids_to_intersect)
  end

  private
    def client
      @@client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["TWITTER_KEY"]
        config.consumer_secret = ENV["TWITTER_SECRET"]
      end
    end

    def get_mutual_followings_data(users_following_ids, following_ids_to_intersect)
      mutual_followers_ids = users_following_ids.to_a & following_ids_to_intersect.to_a
      get_users_by_twitter_ids(mutual_followers_ids)
    end

    def get_users_by_twitter_ids(twitter_ids_array)
      twitter_users = client.users(twitter_ids_array) || []
      twitter_users.map do |twitter_user|
        twitter_user.attrs.merge(:profile_image_url => edit_image_url(twitter_user.profile_image_url))
      end
    end

    def edit_image_url(image_url)
      image_url.to_s.gsub("_normal", "")
    end

    def get_tweets(twitter_handle, quantity)
      client.user_timeline(twitter_handle, {:count => quantity})
    end

    def get_following_ids(twitter_handle)
      client.friend_ids(twitter_handle)
    end
end
