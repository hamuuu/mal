import 'package:flutter/foundation.dart';

class NewsDetailProvider with ChangeNotifier {
  dynamic _news;

  void setNews(dynamic news) {
    _news = news;
  }

  dynamic get news => _news;
}
