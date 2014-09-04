Controller = {
  activateAjaxForms: function () {
    View.twitter_user_form().submit(function () {
      e.preventDefault();
    });
  }
}
