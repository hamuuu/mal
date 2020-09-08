class AnimeSeasonListModel {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  String seasonName;
  int seasonYear;
  List<Anime> anime;

  AnimeSeasonListModel(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.seasonName,
      this.seasonYear,
      this.anime});

  AnimeSeasonListModel.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    seasonName = json['season_name'];
    seasonYear = json['season_year'];
    if (json['anime'] != null) {
      anime = new List<Anime>();
      json['anime'].forEach((v) {
        anime.add(new Anime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    data['season_name'] = this.seasonName;
    data['season_year'] = this.seasonYear;
    if (this.anime != null) {
      data['anime'] = this.anime.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Anime {
  int malId;
  String url;
  String title;
  String imageUrl;
  String synopsis;
  String type;
  String airingStart;
  int episodes;
  int members;
  List<Genres> genres;
  String source;
  List<Producers> producers;
  String score;
  List<String> licensors;
  bool r18;
  bool kids;
  bool continuing;

  Anime(
      {this.malId,
      this.url,
      this.title,
      this.imageUrl,
      this.synopsis,
      this.type,
      this.airingStart,
      this.episodes,
      this.members,
      this.genres,
      this.source,
      this.producers,
      this.score,
      this.licensors,
      this.r18,
      this.kids,
      this.continuing});

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    title = json['title'];
    imageUrl = json['image_url'];
    synopsis = json['synopsis'];
    type = json['type'];
    airingStart = json['airing_start'];
    episodes = json['episodes'] != null ? json['episodes'] : 0;
    members = json['members'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    source = json['source'];
    if (json['producers'] != null) {
      producers = new List<Producers>();
      json['producers'].forEach((v) {
        producers.add(new Producers.fromJson(v));
      });
    }
    score = json['score'] != null ? json['score'].toString() : "0";
    licensors = json['licensors'].cast<String>();
    r18 = json['r18'];
    kids = json['kids'];
    continuing = json['continuing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['synopsis'] = this.synopsis;
    data['type'] = this.type;
    data['airing_start'] = this.airingStart;
    data['episodes'] = this.episodes;
    data['members'] = this.members;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['source'] = this.source;
    if (this.producers != null) {
      data['producers'] = this.producers.map((v) => v.toJson()).toList();
    }
    data['score'] = this.score;
    data['licensors'] = this.licensors;
    data['r18'] = this.r18;
    data['kids'] = this.kids;
    data['continuing'] = this.continuing;
    return data;
  }
}

class Genres {
  int malId;
  String type;
  String name;
  String url;

  Genres({this.malId, this.type, this.name, this.url});

  Genres.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Producers {
  int malId;
  String type;
  String name;
  String url;

  Producers({this.malId, this.type, this.name, this.url});

  Producers.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
