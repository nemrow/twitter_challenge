Controller = {
  activateAjaxForms: function () {
    View.twitter_user_form().submit(function () {
      e.preventDefault();
    });
  },

  getTweetsFromServerHandler: function (that) {
    $.get('/twitter_user', $(that).serialize(), function (results) {
      View.mainContent().html(TEMPLATES.tweet_template({tweets: results}));
    }).fail(function() {
      View.mainContent().html(TEMPLATES.error_template());
    });
  },

  getMutualFollowersFromServerHandler: function (that) {
    $.get('/twitter_mutual_followers', $(that).serialize(), function (results) {
      View.mainContent().html(TEMPLATES.mutual_followers_template({mutual_followers: results}));
    }).fail(function() {
      View.mainContent().html(TEMPLATES.error_template());
    });
  }
}
