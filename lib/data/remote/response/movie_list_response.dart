class MovieListResponse {
  int totalPages;
  Dates dates;
  int page;
  int totalResults;
  List<Movie> results;
  String error = '';

  MovieListResponse(
      {this.totalPages,
        this.dates,
        this.page,
        this.totalResults,
        this.results});

  MovieListResponse.error(this.error);

  MovieListResponse.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
    page = json['page'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  String minimum;
  String maximum;

  Dates({this.minimum, this.maximum});

  Dates.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    return data;
  }
}

class Movie {
  double voteAverage;
  int id;
  int voteCount;
  String releaseDate;
  bool adult;
  String backdropPath;
  String title;
  List<int> genreIds;
  double popularity;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  String overview;
  bool video;

  Movie(
      {this.voteAverage,
        this.id,
        this.voteCount,
        this.releaseDate,
        this.adult,
        this.backdropPath,
        this.title,
        // this.genreIds,
        this.popularity,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.overview,
        this.video});

  Movie.fromJson(Map<String, dynamic> json) {
    voteAverage = json['vote_average'].toDouble();
    id = json['id'];
    voteCount = json['vote_count'];
    releaseDate = json['release_date'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    title = json['title'];
    genreIds = json['genre_ids'].cast<int>();
    popularity = json['popularity'] as double;
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['vote_average'] = this.voteAverage;
    data['id'] = this.id;
    data['vote_count'] = this.voteCount;
    data['release_date'] = this.releaseDate;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['title'] = this.title;
    data['genre_ids'] = this.genreIds;
    data['popularity'] = this.popularity;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['overview'] = this.overview;
    data['video'] = this.video;
    return data;
  }
}