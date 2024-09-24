class Movie {
  final String title;
  final String summary;
  final String imageUrl;

  Movie({required this.title, required this.summary, required this.imageUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['name'],
      summary: json['summary'] ?? 'No summary available',
      imageUrl: json['image'] != null ? json['image']['medium'] : '',
    );
  }
}
