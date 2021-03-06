import 'package:flutter/material.dart';
import 'package:mal/component/genre_anime_list.dart';
import 'package:mal/pages/bottom_navbar.dart';
import 'package:mal/pages/anime_detail.dart';
import 'package:mal/pages/login.dart';
import 'package:mal/pages/news_detail.dart';
import 'package:mal/component/anime_detail_review.dart';
import 'package:mal/pages/services/genre.dart';
import 'package:mal/pages/services/schedules.dart';
import 'package:mal/pages/services/season.dart';
import 'package:mal/pages/services/anime_list.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case '/':
    //   return MaterialPageRoute(
    //     builder: (context) => Login(),
    //   );
    //   break;
    case '/':
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
    case 'schedules':
      return MaterialPageRoute(
        builder: (context) => Schedules(),
      );
      break;
    case 'genre':
      return MaterialPageRoute(
        builder: (context) => Genre(),
      );
    case 'genreAnimeList':
      return MaterialPageRoute(
        builder: (context) => GenreAnimeList(),
      );
      break;

    default:
      return MaterialPageRoute(builder: (context) => BottomNavbar());
  }
}
