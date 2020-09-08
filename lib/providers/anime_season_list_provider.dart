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
    url =
        'https://api.jikan.moe/v3/season/' + year + '/' + season.toLowerCase();
    inspect(url);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return AnimeSeasonListModel.fromJson(json.decode(response.body));
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

  String get season => _season;
  String get year => _year;
}
