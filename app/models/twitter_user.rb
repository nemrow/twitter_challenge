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
      if Rails.env == "development"
        return JSON.parse(File.read('spec/fixtures/mutual_followers.json'))["mutual_followers"]
      end
      mutual_followers_ids = users_follower_ids.to_a & follower_ids_to_intersect.to_a
      mutual_follower_objects = client.users(mutual_followers_ids)
      edit_twitter_users_data(mutual_follower_objects)
    end

    def edit_twitter_users_data(mutual_follower_objects)
      mutual_follower_objects.map do |current_follower|
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
      if Rails.env == "development"
        return JSON.parse(File.read('spec/fixtures/follower_ids_1.json'))["follower_ids"] if (twitter_handle == "nemrow")
        return JSON.parse(File.read('spec/fixtures/follower_ids_2.json'))["follower_ids"] if (twitter_handle == "dpolaske")
      end
      client.follower_ids(twitter_handle)
    end
end
