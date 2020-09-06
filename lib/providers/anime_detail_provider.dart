import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:http/http.dart' as http;

class AnimeDetailProvider with ChangeNotifier {
  String _id;
  String _title;

  void setIdAndTitle(String id, String title) {
    _id = id;
    _title = title;
  }

  Future<Anime> fetchAnimeDetail(String malId) async {
    String url = 'https://api.jikan.moe/v3/anime/$malId';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Anime.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeDetail(malId);
    } else {
      throw Exception('Failed to load data');
    }
  }

  String get id => _id;
  String get title => _title;
}
