TwitterChallenge::Application.routes.draw do
  root :to => 'main#index'

  get 'twitter_user', :to => 'twitter_user#show'
  get 'twitter_mutual_followers', :to => 'twitter_mutual_followers#show'
end
