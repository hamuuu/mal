class SeasonArchiveModel {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Archive> archive;

  SeasonArchiveModel(
      {this.requestHash,
      this.requestCached,
      this.requestCacheExpiry,
      this.archive});

  SeasonArchiveModel.fromJson(Map<String, dynamic> json) {
    requestHash = json['request_hash'];
    requestCached = json['request_cached'];
    requestCacheExpiry = json['request_cache_expiry'];
    if (json['archive'] != null) {
      archive = new List<Archive>();
      json['archive'].forEach((v) {
        archive.add(new Archive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_hash'] = this.requestHash;
    data['request_cached'] = this.requestCached;
    data['request_cache_expiry'] = this.requestCacheExpiry;
    if (this.archive != null) {
      data['archive'] = this.archive.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Archive {
  int year;
  List<String> seasons;

  Archive({this.year, this.seasons});

  Archive.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    seasons = json['seasons'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['seasons'] = this.seasons;
    return data;
  }
}
