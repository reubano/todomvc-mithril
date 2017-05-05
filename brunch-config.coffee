exports.config =
  # See http://brunch.io/#documentation for docs.
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

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^app/
        'stylesheets/vendor.css': /^vendor/

  sourceMaps: 'absoluteUrl'
