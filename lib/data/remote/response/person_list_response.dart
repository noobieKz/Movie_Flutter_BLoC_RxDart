class PersonsListResponse {
  int page;
  List<Person> results;
  int totalPages;
  int totalResults;
  String error = '';

  PersonsListResponse.error(this.error);

  PersonsListResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  PersonsListResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Person>();
      json['results'].forEach((v) {
        results.add(new Person.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Person {
  bool adult;
  int gender;
  String name;
  int id;
  // List<KnownFor> knownFor =[];
  String knownForDepartment;
  String profilePath;
  double popularity;
  String mediaType;

  Person(
      {this.adult,
        this.gender,
        this.name,
        this.id,
        // this.knownFor,
        this.knownForDepartment,
        this.profilePath,
        this.popularity,
        this.mediaType});

  Person.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    name = json['name'];
    id = json['id'];
    // if (json['known_for'] != null) {
    //   knownFor = new List<KnownFor>();
    //   json['known_for'].forEach((v) {
    //     knownFor.add(new KnownFor.fromJson(v));
    //   });
    // }
    knownForDepartment = json['known_for_department'];
    profilePath = json['profile_path'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['id'] = this.id;
    // if (this.knownFor != null) {
    //   data['known_for'] = this.knownFor.map((v) => v.toJson()).toList();
    // }
    data['known_for_department'] = this.knownForDepartment;
    data['profile_path'] = this.profilePath;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}

class KnownFor {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  double popularity;
  String mediaType;
  String firstAirDate;
  String name;
  List<String> originCountry = [];
  String originalName;

  KnownFor(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.popularity,
        this.mediaType,
        this.firstAirDate,
        this.name,
        this.originCountry,
        this.originalName});

  KnownFor.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    originCountry = json['origin_country'].cast<String>();
    originalName = json['original_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    data['first_air_date'] = this.firstAirDate;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    data['original_name'] = this.originalName;
    return data;
  }
}