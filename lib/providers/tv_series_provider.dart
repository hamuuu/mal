import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:http/http.dart' as http;

class TvSeriesFilterProvider with ChangeNotifier {
  bool _onGoing = false;
  String _orderBy;
  int _page = 1;

  Future<AnimeListModel> fetchAnimeList(bool onGoing, String orderBy) async {
    String url = 'http://api.jikan.moe/v3/search/anime?type=tv';
    url = url + '&page=' + page.toString();
    if (orderBy == "Score") url = url + '&order_by=score';
    if (orderBy == "Title") url = url + '&order_by=title';
    if (orderBy == "Active Members") url = url + '&order_by=members';
    if (onGoing) url = url + '&status=airing';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeList(onGoing, orderBy);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AnimeListModel> fetchAnimeSearchList(String query) async {
    String url =
        'http://api.jikan.moe/v3/search/anime?type=tv&page=1&limit=8&q=$query';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeList(onGoing, orderBy);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void editFilter(bool onGoing, String orderBy, int page) {
    _onGoing = onGoing;
    _orderBy = orderBy;
    _page = page;
    notifyListeners();
  }

  void removeFilter() {
    _onGoing = false;
    _orderBy = "Score";
    _page = 1;
    notifyListeners();
  }

  bool get onGoing => _onGoing;
  String get orderBy => _orderBy;
  int get page => _page;
}
