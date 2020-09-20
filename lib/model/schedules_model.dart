class SchedulesModel {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Day> day;

  SchedulesModel(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.day});

  SchedulesModel.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    if (json['monday'] != null) {
      day = new List<Day>();
      json['monday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['sunday'] != null) {
      day = new List<Day>();
      json['sunday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      day = new List<Day>();
      json['tuesday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      day = new List<Day>();
      json['wednesday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      day = new List<Day>();
      json['thursday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      day = new List<Day>();
      json['friday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
    if (json['saturday'] != null) {
      day = new List<Day>();
      json['saturday'].forEach((v) {
        day.add(new Day.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    if (this.day != null) {
      data['day'] = this.day.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
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
  double score;
  List<String> licensors;
  bool r18;
  bool kids;

  Day(
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
      this.kids});

  Day.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    title = json['title'];
    imageUrl = json['image_url'];
    synopsis = json['synopsis'];
    type = json['type'];
    airingStart = json['airing_start'];
    episodes = json['episodes'];
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
    score = score != null ? json['score'] + .0 : null;
    licensors = json['licensors'].cast<String>();
    r18 = json['r18'];
    kids = json['kids'];
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
