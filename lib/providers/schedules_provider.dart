import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mal/model/schedules_model.dart';

class SchedulesProvider with ChangeNotifier {
  String _day;
  Future<SchedulesModel> _futureSchedules;

  Future<SchedulesModel> fetchSchedules(String day) async {
    String url = 'https://api.jikan.moe/v3/schedule/' + day;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SchedulesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setFutureSchedules(String day) {
    _day = day;
    _futureSchedules = fetchSchedules(day);
    notifyListeners();
  }

  String get day => _day;
  Future<SchedulesModel> get futureSchedules => _futureSchedules;
}
