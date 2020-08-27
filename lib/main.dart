import 'package:mal/providers/mal_account_provider.dart';
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
