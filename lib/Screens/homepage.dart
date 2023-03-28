import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.model.dart';
import 'package:movies_app/services/tmdb_service.dart';

class HomeScreen extends StatelessWidget {
  final TMDB tmdb = TMDB();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            4,
            (index) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: tmdb.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: Text('No data found'));
                  }

                  MovieResponse movieResponse = snapshot.data as MovieResponse;

                  return Row(
                    children: movieResponse.movies
                        .map(
                          (movie) => Container(
                            margin: const EdgeInsets.all(
                              16,
                            ),
                            height: 256,
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0,
                                      offset: Offset(06, 6),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                    tmdb.getImageURL(movie.posterPath!)),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
