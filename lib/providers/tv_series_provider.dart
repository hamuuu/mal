import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:http/http.dart' as http;

class TvSeriesFilterProvider with ChangeNotifier {
  bool _onGoing = false;
  String _orderBy = "Score";

  Future<AnimeListModel> fetchAnimeList(bool onGoing, String orderBy) async {
    String url = 'http://api.jikan.moe/v3/search/anime?type=tv&page=1&limit=10';
    if (orderBy == "Score") url = url + '&order_by=score';
    if (orderBy == "Title") url = url + '&order_by=title';
    if (orderBy == "Active Members") url = url + '&order_by=members';
    if (onGoing) url = url + '&status=airing';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void editFilter(bool onGoing, String orderBy) {
    _onGoing = onGoing;
    _orderBy = orderBy;
    notifyListeners();
  }

  void removeFilter() {
    _onGoing = null;
    _orderBy = null;
    notifyListeners();
  }

  bool get onGoing => _onGoing;
  String get orderBy => _orderBy;
}
