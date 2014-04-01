gulp = require 'gulp'
coffee = require 'gulp-coffee'
less = require 'gulp-less'
gutil = require 'gulp-util'
notify = require 'gulp-notify'
exec = require('child_process').exec
sys = require 'sys'

lessDir = 'app/assets/less'
coffeeDir = 'app/assets/coffee'
phpDir = 'app/**.*php'
targetCssDir = 'public/css'
targetJsDir = 'public/js'

gulp.task 'less', ->
  gulp.src lessDir + '/**/*.less'
  .pipe less().on 'error', gutil.log
  .pipe gulp.dest(targetCssDir)
  .pipe notify('Compiled Less Files')

gulp.task 'coffee', ->
  gulp.src coffeeDir + '/**/*.coffee'
  .pipe coffee().on 'error', gutil.log
  .pipe gulp.dest(targetJsDir)
  .pipe notify('Compiled CoffeeScript Files')

gulp.task 'phpspec', ->
  exec 'vendor/bin/phpspec run', (error, stdout) ->
    if(error)
      sys.puts error
    sys.puts stdout


gulp.task 'phpunit', ->
  exec 'phpunit', (error, stdout) ->
    if(error)
      sys.puts error
    sys.puts stdout

gulp.task 'watch', ->
  gulp.watch lessDir + '/**/*.less', ['less']
  gulp.watch coffeeDir + '/**/*.coffee', ['coffee']
  gulp.watch phpDir, ['phpspec', 'phpunit']


gulp.task 'default', ['less', 'coffee', 'phpspec', 'phpunit', 'watch'], ->
  notify 'Running default task'
