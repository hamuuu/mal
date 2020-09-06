class ReviewAnime {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Reviews> reviews;

  ReviewAnime(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.reviews});

  ReviewAnime.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int malId;
  String url;
  Null type;
  int helpfulCount;
  String date;
  Reviewer reviewer;
  String content;

  Reviews(
      {this.malId,
      this.url,
      this.type,
      this.helpfulCount,
      this.date,
      this.reviewer,
      this.content});

  Reviews.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    type = json['type'];
    helpfulCount = json['helpful_count'];
    date = json['date'];
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['type'] = this.type;
    data['helpful_count'] = this.helpfulCount;
    data['date'] = this.date;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer.toJson();
    }
    data['content'] = this.content;
    return data;
  }
}

class Reviewer {
  String url;
  String imageUrl;
  String username;
  int episodesSeen;
  Scores scores;

  Reviewer(
      {this.url, this.imageUrl, this.username, this.episodesSeen, this.scores});

  Reviewer.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    imageUrl = json['image_url'];
    username = json['username'];
    episodesSeen = json['episodes_seen'];
    scores =
        json['scores'] != null ? new Scores.fromJson(json['scores']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['username'] = this.username;
    data['episodes_seen'] = this.episodesSeen;
    if (this.scores != null) {
      data['scores'] = this.scores.toJson();
    }
    return data;
  }
}

class Scores {
  int overall;
  int story;
  int animation;
  int sound;
  int character;
  int enjoyment;

  Scores(
      {this.overall,
      this.story,
      this.animation,
      this.sound,
      this.character,
      this.enjoyment});

  Scores.fromJson(Map<String, dynamic> json) {
    overall = json['overall'];
    story = json['story'];
    animation = json['animation'];
    sound = json['sound'];
    character = json['character'];
    enjoyment = json['enjoyment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overall'] = this.overall;
    data['story'] = this.story;
    data['animation'] = this.animation;
    data['sound'] = this.sound;
    data['character'] = this.character;
    data['enjoyment'] = this.enjoyment;
    return data;
  }
}
