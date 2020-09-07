import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_news_provider.dart';
import 'package:mal/providers/anime_recommend_provider.dart';
import 'package:mal/providers/anime_review_provider.dart';
import 'package:mal/providers/mal_account_provider.dart';
import 'package:mal/providers/news_detail_provider.dart';
import 'package:mal/providers/tv_series_provider.dart';
import 'package:provider/provider.dart';
import 'package:mal/router.dart' as router;

import 'package:mal/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => MalAccountProvider()),
        ChangeNotifierProvider(create: (context) => TvSeriesFilterProvider()),
        ChangeNotifierProvider(create: (context) => AnimeDetailProvider()),
        ChangeNotifierProvider(create: (context) => AnimeNewsProvider()),
        ChangeNotifierProvider(create: (context) => AnimeReviewProvider()),
        ChangeNotifierProvider(create: (context) => AnimeRecommendProvider()),
        ChangeNotifierProvider(create: (context) => NewsDetailProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[100],
          accentColor: Colors.blueAccent,
          accentColorBrightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: '/',
      ),
    ),
  );
}
