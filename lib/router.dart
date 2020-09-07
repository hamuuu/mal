import 'package:flutter/material.dart';
import 'package:mal/pages/bottom_navbar.dart';
import 'package:mal/pages/anime_detail.dart';
import 'package:mal/pages/login.dart';
import 'package:mal/pages/news_detail.dart';
import 'package:mal/pages/review.dart';
import 'package:mal/pages/services/movies.dart';
import 'package:mal/pages/services/tv_series.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => Login(),
      );
      break;
    case 'home':
      return MaterialPageRoute(
        builder: (context) => BottomNavbar(),
      );
      break;
    case 'tvSeries':
      return MaterialPageRoute(
        builder: (context) => TvSeries(),
      );
      break;
    case 'movie':
      return MaterialPageRoute(
        builder: (context) => Movie(),
      );
      break;
    case 'detail':
      return MaterialPageRoute(
        builder: (context) => DetailAnime(),
      );
      break;
    case 'review':
      return MaterialPageRoute(
        builder: (context) => AnimeReview(),
      );
      break;
    case 'detailnews':
      return MaterialPageRoute(
        builder: (context) => NewsDetail(),
      );
      break;

    default:
      return MaterialPageRoute(builder: (context) => BottomNavbar());
  }
}
