import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        children: [
          Image.network(movie.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              movie.summary,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
