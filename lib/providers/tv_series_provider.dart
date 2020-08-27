import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:http/http.dart' as http;

class TvSeriesFilterProvider with ChangeNotifier {
  bool _onGoing = false;

  Future<AnimeListModel> fetchAnimeList(bool onGoing) async {
    String url =
        'http://api.jikan.moe/v3/search/anime?order_by=score&type=tv&page=1&limit=10';
    if (onGoing) url = url + '&status=airing';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void editFilter(bool onGoing) {
    _onGoing = onGoing;
    notifyListeners();
  }

  void removeFilter() {
    _onGoing = null;
    notifyListeners();
  }

  bool get onGoing => _onGoing;
}
