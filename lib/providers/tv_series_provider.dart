import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:http/http.dart' as http;

class TvSeriesFilterProvider with ChangeNotifier {
  bool _onGoing = false;
  String _orderBy = "Score";
  int _page = 1;
  String _query;

  Future<AnimeListModel> fetchAnimeList(
      bool onGoing, String orderBy, String query) async {
    String url = 'http://api.jikan.moe/v3/search/anime?type=tv';
    url = url + '&page=' + page.toString();
    if (orderBy == "Score") url = url + '&order_by=score';
    if (orderBy == "Title") url = url + '&order_by=title';
    if (orderBy == "Active Members") url = url + '&order_by=members';
    if (onGoing) url = url + '&status=airing';
    if (query != null) url = url + '&q=$query';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeList(onGoing, orderBy, query);
    } else {
      return this.fetchAnimeList(onGoing, orderBy, query);
    }
  }

  Future<AnimeListModel> fetchAnimeSearchList(String query) async {
    String url =
        'http://api.jikan.moe/v3/search/anime?type=tv&page=1&limit=8&q=$query';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 429) {
      return this.fetchAnimeList(onGoing, orderBy, query);
    } else {
      throw Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Failed to load data. Click here to reload'),
              IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle),
                  onPressed: () => this.fetchAnimeList(onGoing, orderBy, query))
            ],
          ),
        ),
      );
    }
  }

  void editFilter(bool onGoing, String orderBy, int page, String query) {
    _onGoing = onGoing;
    _orderBy = orderBy;
    _page = page;
    _query = query;
    notifyListeners();
  }

  void removeFilter() {
    _onGoing = false;
    _orderBy = "Score";
    _page = 1;
    _query = null;
    notifyListeners();
  }

  void removeSearch() {
    _query = null;
    notifyListeners();
  }

  bool get onGoing => _onGoing;
  String get orderBy => _orderBy;
  int get page => _page;
  String get query => _query;
}