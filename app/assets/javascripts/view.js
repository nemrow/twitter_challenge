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
      Controller.getTweetsFromServerHandler(this);
      e.preventDefault();
    });

    View.followerIntersectionForm().submit(function (e) {
      View.displayLoading();
      Controller.getMutualFollowersFromServerHandler(this);
      e.preventDefault();
    });
  }
}
