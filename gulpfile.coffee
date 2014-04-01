gulp = require 'gulp'
coffee = require 'gulp-coffee'
sass = require 'gulp-ruby-sass'
gutil = require 'gulp-util'
notify = require 'gulp-notify'
exec = require('child_process').exec
sys = require 'sys'

lessDir = '_assets/sass'
coffeeDir = '_assets/coffee'
targetCssDir = 'css/min'
targetJsDir = 'js/min'

gulp.task 'sass', ->
  gulp.src lessDir + '/**/*.scss'
  .pipe less().on 'error', gutil.log
  .pipe gulp.dest(targetCssDir)
  .pipe notify('Compiled Sass Files')

gulp.task 'coffee', ->
  gulp.src coffeeDir + '/**/*.coffee'
  .pipe coffee().on 'error', gutil.log
  .pipe gulp.dest(targetJsDir)
  .pipe notify('Compiled CoffeeScript Files')

gulp.task 'watch', ->
  gulp.watch lessDir + '/**/*.less', ['less']
  gulp.watch coffeeDir + '/**/*.coffee', ['coffee']

gulp.task 'default', ['less', 'coffee', 'watch'], ->
  notify 'Running default task'
