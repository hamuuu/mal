class MalAccount {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  int userId;
  String username;
  String url;
  String imageUrl;
  String lastOnline;
  String gender;
  String birthday;
  String location;
  String joined;
  AnimeStats animeStats;
  MangaStats mangaStats;
  String about;

  MalAccount(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.userId,
      this.username,
      this.url,
      this.imageUrl,
      this.lastOnline,
      this.gender,
      this.birthday,
      this.location,
      this.joined,
      this.animeStats,
      this.mangaStats,
      this.about});

  MalAccount.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    userId = json['user_id'];
    username = json['username'];
    url = json['url'];
    imageUrl = json['image_url'];
    lastOnline = json['last_online'];
    gender = json['gender'];
    birthday = json['birthday'];
    location = json['location'];
    joined = json['joined'];
    animeStats = json['anime_stats'] != null
        ? new AnimeStats.fromJson(json['anime_stats'])
        : null;
    mangaStats = json['manga_stats'] != null
        ? new MangaStats.fromJson(json['manga_stats'])
        : null;
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['last_online'] = this.lastOnline;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['location'] = this.location;
    data['joined'] = this.joined;
    if (this.animeStats != null) {
      data['anime_stats'] = this.animeStats.toJson();
    }
    if (this.mangaStats != null) {
      data['manga_stats'] = this.mangaStats.toJson();
    }
    data['about'] = this.about;
    return data;
  }
}

class AnimeStats {
  double daysWatched;
  double meanScore;
  int watching;
  int completed;
  int onHold;
  int dropped;
  int planToWatch;
  int totalEntries;
  int rewatched;
  int episodesWatched;

  AnimeStats(
      {this.daysWatched,
      this.meanScore,
      this.watching,
      this.completed,
      this.onHold,
      this.dropped,
      this.planToWatch,
      this.totalEntries,
      this.rewatched,
      this.episodesWatched});

  AnimeStats.fromJson(Map<String, dynamic> json) {
    daysWatched = json['days_watched'] + .0;
    meanScore = json['mean_score'] + .0;
    watching = json['watching'];
    completed = json['completed'];
    onHold = json['on_hold'];
    dropped = json['dropped'];
    planToWatch = json['plan_to_watch'];
    totalEntries = json['total_entries'];
    rewatched = json['rewatched'];
    episodesWatched = json['episodes_watched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days_watched'] = this.daysWatched;
    data['mean_score'] = this.meanScore;
    data['watching'] = this.watching;
    data['completed'] = this.completed;
    data['on_hold'] = this.onHold;
    data['dropped'] = this.dropped;
    data['plan_to_watch'] = this.planToWatch;
    data['total_entries'] = this.totalEntries;
    data['rewatched'] = this.rewatched;
    data['episodes_watched'] = this.episodesWatched;
    return data;
  }
}

class MangaStats {
  double daysRead;
  double meanScore;
  int reading;
  int completed;
  int onHold;
  int dropped;
  int planToRead;
  int totalEntries;
  int reread;
  int chaptersRead;
  int volumesRead;

  MangaStats(
      {this.daysRead,
      this.meanScore,
      this.reading,
      this.completed,
      this.onHold,
      this.dropped,
      this.planToRead,
      this.totalEntries,
      this.reread,
      this.chaptersRead,
      this.volumesRead});

  MangaStats.fromJson(Map<String, dynamic> json) {
    daysRead = json['days_read'] + .0;
    meanScore = json['mean_score'] + .0;
    reading = json['reading'];
    completed = json['completed'];
    onHold = json['on_hold'];
    dropped = json['dropped'];
    planToRead = json['plan_to_read'];
    totalEntries = json['total_entries'];
    reread = json['reread'];
    chaptersRead = json['chapters_read'];
    volumesRead = json['volumes_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days_read'] = this.daysRead;
    data['mean_score'] = this.meanScore;
    data['reading'] = this.reading;
    data['completed'] = this.completed;
    data['on_hold'] = this.onHold;
    data['dropped'] = this.dropped;
    data['plan_to_read'] = this.planToRead;
    data['total_entries'] = this.totalEntries;
    data['reread'] = this.reread;
    data['chapters_read'] = this.chaptersRead;
    data['volumes_read'] = this.volumesRead;
    return data;
  }
}
