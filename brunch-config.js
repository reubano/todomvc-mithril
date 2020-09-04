exports.config = {
  // See http://brunch.io/docs/config for docs.
  plugins: {
    coffeelint: {
      pattern: /^app\/.*\.coffee$/,
      options: {
        indentation: {
          value: 2,
          level: "error"
        }
      }
    },
    cleancss: {
      keepSpecialComments: 0,
      removeEmpty: true
    },
    terser: {
      mangle: false
    }
  },
  npm: {
    styles: {
      "todomvc-app-css": ["index.css"]
    }
  },
  files: {
    javascripts: {
      joinTo: {
        "javascripts/app.js": /^app/,
        "javascripts/vendor.js": /^(?!app)/
      }
    },
    stylesheets: {
      joinTo: {
        "stylesheets/app.css": /^app/,
        "stylesheets/vendor.css": /^node_modules/
      }
    }
  },
  modules: {
    autoRequire: {
      "javascripts/app.js": ["initialize"]
    }
  },
  sourceMaps: "absoluteUrl",
  notifications: false
};
