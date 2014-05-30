/*
 * grunt-fmpp
 * https://github.com/yun77op/grunt-fmpp
 *
 * Copyright (c) 2014 yun77op
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    jshint: {
      all: [
        'Gruntfile.js',
        'tasks/*.js',
        '<%= nodeunit.tests %>'
      ],
      options: {
        jshintrc: '.jshintrc'
      }
    },

    // Before generating any new files, remove any previously-created files.
    clean: {
      tests: ['tmp']
    },

    // Configuration to be run (and then tested).
    fmpp: {
      dev: {
        options: {
          appDir: 'example/fmpp',
          lib: 'example/fmpp/lib'
        }
      }
    },

    connect: {
      server: {
        options: {
          port: 8000,
          base: 'example/tmp/public',
          logger: 'dev',
          hostname: 'localhost',
          keepalive: true
        }
      }
    },

    watch: {
      fmpp: {
        files: 'example/src/main/webapp/WEB-INFO/tmpl/**/*.ftl',
        tasks: ['fmpp:dev']
      }
    },

    // Unit tests.
    nodeunit: {
      tests: ['test/*_test.js']
    }

  });

  // Actually load this plugin's task(s).
  grunt.loadTasks('tasks');

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');

  // Whenever the "test" task is run, first clean the "tmp" dir, then run this
  // plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'fmpp', 'nodeunit']);

  // By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test']);


//  grunt.loadNpmTasks('grunt-contrib-connect');
//  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('server', ['fmpp', 'connect:server', 'watch']);


};
