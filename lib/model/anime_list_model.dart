class AnimeListModel {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Animes> animes;
  int lastPage;

  AnimeListModel(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.animes,
      this.lastPage});

  AnimeListModel.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    if (json['results'] != null) {
      animes = new List<Animes>();
      json['results'].forEach((v) {
        animes.add(new Animes.fromJson(v));
      });
    }
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    if (this.animes != null) {
      data['animes'] = this.animes.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    return data;
  }
}

class Animes {
  int malId;
  String url;
  String imageUrl;
  String title;
  bool airing;
  String synopsis;
  String type;
  int episodes;
  double score;
  String startDate;
  String endDate;
  int members;
  String rated;

  Animes(
      {this.malId,
      this.url,
      this.imageUrl,
      this.title,
      this.airing,
      this.synopsis,
      this.type,
      this.episodes,
      this.score,
      this.startDate,
      this.endDate,
      this.members,
      this.rated});

  Animes.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    title = json['title'];
    airing = json['airing'];
    synopsis = json['synopsis'];
    type = json['type'];
    episodes = json['episodes'];
    score = json['score'] + .0;
    startDate = json['start_date'];
    endDate = json['end_date'];
    members = json['members'];
    rated = json['rated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['airing'] = this.airing;
    data['synopsis'] = this.synopsis;
    data['type'] = this.type;
    data['episodes'] = this.episodes;
    data['score'] = this.score;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['members'] = this.members;
    data['rated'] = this.rated;
    return data;
  }
}
