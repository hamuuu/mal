import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:koukicons/search.dart';
import 'package:koukicons/search2.dart';
import 'package:mal/component/anime_list.dart';
import 'package:mal/component/filter_bar_button.dart';
import 'package:mal/component/search_bar.dart';
import 'package:mal/providers/tv_series_provider.dart';
import 'package:provider/provider.dart';

class TvSeries extends StatefulWidget {
  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  bool _showSearchBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSearchBar = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  'List Anime',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tv Series',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<TvSeriesFilterProvider>(context).removeFilter();
                },
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10, top: 8),
                child: Image(
                  image: AssetImage('assets/logo-appbar.png'),
                ),
              )
            ],
            floating: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [Colors.blue[300], Colors.blue[200]],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            expandedHeight: 70,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                FliterBarButton(),
                SizedBox(height: 5),
                Divider(color: Colors.grey[400], thickness: 1.5, height: 10),
                SizedBox(height: 10),
                _showSearchBar ? SearchBar() : SizedBox.shrink(),
                SizedBox(height: 15),
                AnimeList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
