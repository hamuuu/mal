import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/anime_review_model.dart';

class AnimeReviewProvider with ChangeNotifier {
  String _episode;

  void setEpisode(String episode) {
    _episode = episode;
  }

  Future<ReviewAnime> fetchAnimeReview(String malId) async {
    String url = 'https://api.jikan.moe/v3/anime/$malId/reviews';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ReviewAnime.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeReview(malId);
    } else {
      throw Exception('Failed to load data');
    }
  }

  String get episode => _episode;
}
