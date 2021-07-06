import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/src/actions/get_movies.dart';

import 'package:movie_app/src/container/movies_container.dart';
import 'package:movie_app/src/container/is_loading_container.dart';
import 'package:movie_app/src/models/app_state.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final bool isLoading = store.state.isLoading;
    final double max = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    final double delta = max - offset;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double threshold = screenHeight * 0.2;

    if (delta < threshold && !isLoading) {
      store.dispatch(GetMovies());
    }
  }

  //called when this object is removed from the tree permanently.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MoviesContainer(builder: (BuildContext context, List<Movie> movies) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Movie App'),
            actions: <Widget>[
              IsLoadingContainer(
                builder: (BuildContext context, bool isLoading) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.movie),
                    onPressed: () {
                      final Store<AppState> store = StoreProvider.of<AppState>(context);
                      store.dispatch(const GetMovies());
                    },
                  );
                },
              ),
            ],
          ),
          body: MoviesContainer(
            builder: (BuildContext context, List<Movie> movies) {
              return IsLoadingContainer(
                builder: (BuildContext context, bool isLoading) {
                  if (isLoading && movies.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.69,
                    ),
                    controller: _controller,
                    itemCount: movies.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    cacheExtent: MediaQuery.of(context).size.height,
                    itemBuilder: (BuildContext context, int index) {
                      final Movie movie = movies[index];
                      return SizedBox(
                        height: 400,
                        child: GridTile(
                          child: Image.network(movie.image),
                          footer: GridTileBar(
                            backgroundColor: Colors.black,
                            title: Text(movie.title),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ));
    });
  }
}
