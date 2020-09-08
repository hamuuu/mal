import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/anime_recommend_model.dart';

class AnimeRecommendProvider with ChangeNotifier {
  Future<AnimeRecommendModel> fetchAnimeRecommendation(String malId) async {
    String url = 'https://api.jikan.moe/v3/anime/$malId/recommendations';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return AnimeRecommendModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
