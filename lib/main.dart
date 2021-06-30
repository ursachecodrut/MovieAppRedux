import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:movie_app/src/actions/get_movies.dart';
import 'package:movie_app/src/data/movie_api.dart';
import 'package:movie_app/src/middleware/middleware.dart';
import 'package:movie_app/src/models/app_state.dart';
import 'package:movie_app/src/presentation/home_page.dart';
import 'package:movie_app/src/reducer/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  const String apiUrl = 'https/yts.mx/api/v2';
  final Client client = Client();
  final MoviesApi moviesApi = MoviesApi(apiUrl: apiUrl, client: client);
  final AppMiddleware appMiddleware = AppMiddleware(moviesApi: moviesApi);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: appMiddleware.middleware,
  );
  store.dispatch(GetMovies());
  runApp(MovieApp(store: store));
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: const MaterialApp(
          home: HomePage(),
        ));
  }
}
