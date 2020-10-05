import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/genre_anime_list_model.dart';

class GenreAnimeListProvider with ChangeNotifier {
  String _key;
  String _value;
  Future<GenreAnimeListModel> _futureGenreAnimeList;

  void setKeyAndValue(String key, String value) {
    _key = key;
    _value = value;
  }

  void setFutureGenreAnimeList() {
    _futureGenreAnimeList = fetchGenreAnimeList(_key);
  }

  Future<GenreAnimeListModel> fetchGenreAnimeList(String key) async {
    String url = 'https://api.jikan.moe/v3/genre/anime/' + key + '/1';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GenreAnimeListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  String get key => _key;
  String get value => _value;
  Future<GenreAnimeListModel> get futureGenreAnimeList => _futureGenreAnimeList;
}
