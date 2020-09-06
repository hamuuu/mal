import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/anime_news_model.dart';

class AnimeNewsProvider with ChangeNotifier {
  Future<AnimeNewsModel> fetchAnimeNews() async {
    String url =
        'http://newsapi.org/v2/everything?q=anime&apiKey=0cfcf078d27e40e1a5e9d119f1bcd481';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeNewsModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeNews();
    } else {
      return this.fetchAnimeNews();
    }
  }

  Future<AnimeNewsModel> _futureAnimeNews;
  Future<AnimeNewsModel> get futureAnimeNews {
    if (_futureAnimeNews == null) _futureAnimeNews = fetchAnimeNews();
    return _futureAnimeNews;
  }
}
