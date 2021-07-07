library movie;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movie_app/src/models/serializers.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  factory Movie.fromJson(dynamic json) {
    return serializers.deserializeWith(serializer, json)!;
  }

  Movie._();

  String get title;

  int get id;

  @BuiltValueField(wireName: 'medium_cover_image')
  String get image;

  String get summary;

  static Serializer<Movie> get serializer => _$movieSerializer;
}
