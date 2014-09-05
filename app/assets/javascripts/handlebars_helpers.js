Handlebars.registerHelper('any', function(conditional, options) {
  if(conditional.length == 0) {
    return options.fn(this);
  };
});
