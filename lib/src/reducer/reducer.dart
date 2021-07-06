import 'package:movie_app/src/actions/get_movies.dart';
import 'package:movie_app/src/actions/set.dart';
import 'package:movie_app/src/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  (AppState state, dynamic action) {
    print(action);
    return state;
  },
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),

]);

AppState _getMovies(AppState state, GetMovies action) {
  return state.rebuild((AppStateBuilder b) {
    b.isLoading = true;
  });
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    print('page is now: ${state.page + 1}');
    b
      ..movies.addAll(action.movies)
      ..isLoading = false
      ..page = state.page + 1;
  });
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..isLoading = false
      ..error = '${action.error}';
  });
}
AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.rebuild((AppStateBuilder b) {
    b.movies;
  });
}
