import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/anime_season_list.dart';

class AnimeSeasonListProvider with ChangeNotifier {
  String _season = "Summer";
  String _year = DateTime.now().year.toString();

  Future<AnimeSeasonListModel> fetchAnimeSeasonList(
      String year, String season) async {
    String url;
    if (_season != null && _year != null)
      url = 'https://api.jikan.moe/v3/season/' +
          year +
          '/' +
          season.toLowerCase();
    else
      url = 'https://api.jikan.moe/v3/season';

    final response = await http.get(url);
    if (response.statusCode == 200) {
      AnimeSeasonListModel animeList =
          AnimeSeasonListModel.fromJson(json.decode(response.body));

      return animeList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setSeason(String season) {
    _season = season;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    notifyListeners();
  }

  void setYearAndSeason(String year, String season) {
    _year = year;
    _season = season;

    notifyListeners();
  }

  String get season => _season;
  String get year => _year;
}
