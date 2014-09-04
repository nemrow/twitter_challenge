Handlebars.registerHelper('imageCheck', function(index, value) {
  if (index == 0)  {
    var image_string = "<img src='" + value + "'>"
    var image_html = new Handlebars.SafeString(image_string)
    return image_html
  } else {
    return value
  }
});
