exports.config =
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^bower_components/
        'js/create.js': /^vendor(\/|\\)createjs/
    stylesheets:
      joinTo: 
        'styles/app.css' :/^app(\/|\\)styles/
        'styles/vendor.css' : /^bower_components/
    templates:
      joinTo: 'js/templates.js'