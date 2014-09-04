TEMPLATES = {};
$(document).ready(function () {
  var scriptTags = document.querySelectorAll('script[type="text/x-handlebars-template"]');
  Array.prototype.forEach.call(scriptTags, function(script) {
    var name = script.id;
    var content = script.innerHTML;
    TEMPLATES[name] = Handlebars.compile(content);
  });
});
