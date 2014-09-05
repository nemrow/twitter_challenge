TEMPLATES = {};
$(document).ready(function () {
  var scriptTags = $('script[type="text/x-handlebars-template"]');
  $.each(scriptTags, function () {
    var name = this.id;
    var content = this.innerHTML;
    TEMPLATES[name] = Handlebars.compile(content);
  });
});
