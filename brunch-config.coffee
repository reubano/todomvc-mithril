exports.config =
  # See http://brunch.io/docs/config for docs.
  plugins:
    coffeelint:
      pattern: /^app\/.*\.coffee$/
      options:
        indentation:
          value: 2
          level: 'error'
    cleancss:
      keepSpecialComments: 0
      removeEmpty: true
    uglify:
      mangle: true

  npm:
    styles:
      'todomvc-app-css': ['index.css']

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^app/
        'stylesheets/vendor.css': /^node_modules/

  sourceMaps: 'absoluteUrl'
  notifications: false
