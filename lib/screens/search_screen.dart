import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/movie.dart';
import 'dart:convert';
import 'details_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie>? _results;

  Future<void> _searchMovies() async {
    final query = _controller.text;
    if (query.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _results = jsonResponse.map((movie) => Movie.fromJson(movie['show'])).toList();
        });
      } else {
        throw Exception('Failed to load search results');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchMovies,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: _results == null
                ? const Center(child: Text('No results found', style: TextStyle(color: Colors.white)))
                : ListView.builder(
                    itemCount: _results!.length,
                    itemBuilder: (context, index) {
                      final movie = _results![index];
                      return ListTile(
                        title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(movie.summary, style: const TextStyle(color: Colors.white70)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(movie: movie),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
