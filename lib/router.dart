import 'package:flutter/material.dart';
import 'package:mal/pages/bottom_navbar.dart';
import 'package:mal/pages/anime_detail.dart';
import 'package:mal/pages/login.dart';
import 'package:mal/pages/news_detail.dart';
import 'package:mal/pages/review.dart';
import 'package:mal/pages/season.dart';
import 'package:mal/pages/services/anime_list.dart';

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
    case 'animeList':
      return MaterialPageRoute(
        builder: (context) => TvSeries(),
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
    case 'season':
      return MaterialPageRoute(
        builder: (context) => SeasonList(),
      );
      break;

    default:
      return MaterialPageRoute(builder: (context) => BottomNavbar());
  }
}
