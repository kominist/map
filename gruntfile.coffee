module.exports = (grunt) ->
  grunt.initConfig
    pkg : grunt.file.readJSON("package.json")
    coffee:
      test :
        options :
          bare : true
        files :
          "test/js/komitymap-spec.js" : ["test/cs/*-spec.coffee"]

    coffeelint :
      app : ["gruntfile.coffee","src/cs/**/*.coffee", "test/cs/*-spec.coffee"]

    uglify :
      options :
        report : "min"
        preserveComments : no
      compile :
        files :
          "dist/js/komitymap.min.js" : ["dist/js/komitymap.js"]
    
    browserify :
      dist :
        options :
          transform : ["coffeeify"]
        files :
          "dist/js/komitymap.js" : ["src/cs/main.coffee", "src/cs/lib/*.coffee"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-browserify"

  grunt.registerTask "default", [
    "coffeelint"
    "browserify:dist"
    "uglify:compile"
  ]

  grunt.registerTask "test", [
    "coffeelint"
    "coffee:test"
  ]
