import 'package:built_collection/built_collection.dart';
import 'package:movie_app/src/actions/get_movies.dart';
import 'package:movie_app/src/models/app_state.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  (AppState state, dynamic action) {
    print(action);
    return state;
  },
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
]);

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.movies = ListBuilder<Movie>(action.movies);
  });
}
