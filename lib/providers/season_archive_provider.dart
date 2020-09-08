import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/season_archive_model.dart';

class SeasonArchiveProvider with ChangeNotifier {
  Future<SeasonArchiveModel> fetchSeasonArchive() async {
    String url = 'https://api.jikan.moe/v3/season/archive';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SeasonArchiveModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
