require 'spec_helper'

describe TwitterUser do

  it "should return a list of the users mututal followers" do
    TwitterUser.any_instance.stub(:get_follower_ids).with("nemrow").and_return(json_fixture('follower_ids_1.json'))
    TwitterUser.any_instance.stub(:get_follower_ids).with("dpolaske").and_return(json_fixture('follower_ids_2.json'))
    TwitterUser.any_instance.stub(:get_users_by_twitter_ids).with([294784306,73719806,117567114,2337397724]).and_return(json_fixture('mutual_followers.json'))
    assert_equal 4, TwitterUser.new("nemrow").mutual_followers("dpolaske").count
  end

  it "should return a list of the recent tweets" do
    TwitterUser.any_instance.stub(:get_tweets).with("nemrow", 20).and_return(json_fixture('recent_tweets.json'))
    assert_equal 20, TwitterUser.new("nemrow").recent_tweets.count
  end
end
