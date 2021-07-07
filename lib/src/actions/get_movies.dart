import 'package:movie_app/src/models/movie.dart';

class GetMovies {
  const GetMovies();

  @override
  String toString() {
    return 'GetMovies{}';
  }
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;

  @override
  String toString() {
    return 'GetMoviesSuccessful{movies: $movies}';
  }
}

class GetMoviesError {
  GetMoviesError(this.error);

  final Object error;

  @override
  String toString() {
    return 'GetMoviesError{error: $error}';
  }
}
