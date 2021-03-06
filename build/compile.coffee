gulp = require "gulp"
jade = require "gulp-jade"
sass = require "gulp-sass"
coffee = require "gulp-coffee"

livereload  = require "gulp-livereload"
tinylr = require "tiny-lr"

server = tinylr()

gulp.task "compile:html", ->
  gulp.src "src/index.jade"
  .pipe jade { pretty: true }
  .pipe gulp.dest "./"
  .pipe livereload server

gulp.task "compile:pages", ->
  gulp.src "src/pages/*.jade"
  .pipe jade { pretty: true }
  .pipe gulp.dest "./"
  .pipe livereload server

gulp.task "compile:css", ->
  gulp.src(["src/assets/styles/*.sass", "src/assets/styles/*.scss"])
  .pipe sass { errLogToConsole: true }
  .pipe gulp.dest "./dist/assets/styles"
  .pipe livereload server

gulp.task "compile:js", ->
  gulp.src("src/assets/scripts/*.coffee")
  .pipe coffee {pretty: true}
  .pipe gulp.dest "./dist/assets/scripts/"
  .pipe livereload server

  gulp.src("src/assets/config/*.coffee")
  .pipe coffee {pretty: true}
  .pipe gulp.dest "./dist/assets/config/"
  .pipe livereload server

gulp.task "watch", ->
  server.listen 35729, (err) ->
    if err then return console.log err

    gulp.watch "src/**/*.jade", ["compile:html","compile:pages"]
    gulp.watch "src/assets/styles/**/*.sass", ["compile:css"]
    gulp.watch "src/assets/scripts/*.coffee", ["compile:js", "copy"]

gulp.task "compile", ["compile:html", "compile:css", "compile:js","compile:pages"]
