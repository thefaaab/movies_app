import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:movies_app/models/movie.model.dart';

class TMDB {
  final String _apikey = 'd231f0b570dd54eb6ed9ecdc337b93f4';

  final _dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/discover/'),
  );

  getPopularMovies() async {
    MovieResponse res;
    try {
      res = await _dio.get<Map<String, dynamic>>('movie', queryParameters: {
        'api_key': _apikey,
        'sort_by': 'vote_average.asc',
        'vote_average.gte': 8,
        'vote_count.gte': 10000,
      }).then((response) {
        if (response.statusCode != 200) return throw ('Server error');

        if (response.data == null) return throw ('No data found');

        return MovieResponse.fromJson(response.data!);
      });
    } catch (e) {
      print(e);
      return Future.error(e);
    }
    return res;
  }

  String getImageURL(String path) {
    return 'https://image.tmdb.org/t/p/original/$path';
  }
}
