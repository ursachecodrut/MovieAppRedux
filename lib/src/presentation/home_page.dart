import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/actions/movies_container.dart';
import 'package:movie_app/src/models/movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoviesContainer(builder: (BuildContext context, List<Movie> movies) {
      return Scaffold(
        body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = movies[index];

            return ListTile(
              title: Text(movie.title),
            );
          },
        ),
      );
    });
  }
}
