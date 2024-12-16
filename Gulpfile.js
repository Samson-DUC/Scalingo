var gulp = require('gulp');
const sass = require('gulp-sass')(require('sass'));

gulp.task('sass', function (done) {
  gulp.src('assets/sass/style.scss')
    .pipe(sass({
      includePaths: ['assets/sass'],
      errLogToConsole: true
    }))
    .pipe(gulp.dest('assets/css'));
  done();
});
gulp.task('bundle', gulp.series('sass'));
gulp.task('default', gulp.series('bundle'));
