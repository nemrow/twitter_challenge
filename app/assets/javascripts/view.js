View = {
  twitterUserForm: function () {
    return $('.twitter-user-search-form');
  },

  followerIntersectionForm: function () {
    return $('.twitter-mutual-followers-form');
  },

  mainContent: function () {
    return $('.main-content-container');
  },

  displayLoading: function () {
    View.mainContent().html(TEMPLATES.clock_template());
  },

  activateAjaxForms: function () {
    View.twitterUserForm().submit(function (e) {
      View.displayLoading();
      $.get('/twitter_user', $(this).serialize(), function (results) {
        View.mainContent().html(TEMPLATES.tweet_template(results));
      });
      e.preventDefault();
    });

    View.followerIntersectionForm().submit(function (e) {
      View.displayLoading();
      $.get('/twitter_mutual_followers', $(this).serialize(), function (results) {
        View.mainContent().html(TEMPLATES.mutual_followers_template(results));
      });
      e.preventDefault();
    });
  }
}
