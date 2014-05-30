/*
 * grunt-fmpp
 * https://github.com/yun77op/grunt-fmpp
 *
 * Copyright (c) 2014 yun77op
 * Licensed under the MIT license.
 */

'use strict';

var exec = require('child_process').exec;
var path = require('path');


module.exports = function(grunt) {

  // Please see the Grunt documentation for more information regarding task
  // creation: http://gruntjs.com/creating-tasks

  grunt.registerMultiTask('fmpp', 'The best Grunt plugin ever.', function() {
    // Merge task-specific and/or target-specific options with these defaults.
    var options = this.options({
      lib: ''
    });

    var done = this.async();
    var libpath = path.resolve(options.lib);
    var cmd = 'java -cp .:' + __dirname  + '/lib/*:' + libpath + '/* fmpp.tools.CommandLine';

    exec(cmd, {
      cwd: options.appDir
    }, function(error, stdout, stderr) {

      if(stdout) console.log(stdout);
      if(stderr) console.log("ERROR:" + stderr);

      if (error) {
        done(false);
      } else {
        done();
      }
    });

  });

};
