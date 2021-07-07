import 'package:flutter/material.dart';
import 'package:movie_app/src/container/selected_movie_container.dart';
import 'package:movie_app/src/models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectedMovieContainer(
      builder: (BuildContext context, Movie movie) {
        return const Scaffold(
          body: Center(
            child: Text('Movie'),
          ),
        );
      },
    );
  }
}
