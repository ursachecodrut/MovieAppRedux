import 'package:redux/redux.dart';
import 'package:movie_app/src/data/movie_api.dart';
import 'package:movie_app/src/models/app_state.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/actions/get_movies.dart';

class AppMiddleware {
  const AppMiddleware({required MoviesApi moviesApi}) : _moviesApi = moviesApi;

  final MoviesApi _moviesApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetMovies>(_getMovies),
    ];
  }

  Future<void> _getMovies(
      Store<AppState> store, GetMovies action, NextDispatcher next) async {
    next(action);
    try {
      final List<Movie> movies = await _moviesApi.getMovies();
      store.dispatch(GetMoviesSuccessful(movies));
    } catch (error) {
      store.dispatch(GetMoviesError(error));
    }
  }
}
