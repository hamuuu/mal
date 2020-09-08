import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/anime_season_list.dart';

class AnimeSeasonListProvider with ChangeNotifier {
  Future<AnimeSeasonListModel> fetchAnimeSeasonList() async {
    String url = 'https://api.jikan.moe/v3/season';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeSeasonListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
