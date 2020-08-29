import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:mal/providers/tv_series_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();
  Future<AnimeListModel> _futureAnimeList;
  bool _isSearched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do You Want to Search?',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Search your favorite anime here!',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) async {
                      if (value.length >= 3)
                        setState(() {
                          _isSearched = true;
                          _futureAnimeList =
                              Provider.of<TvSeriesFilterProvider>(context)
                                  .fetchAnimeSearchList(value);
                        });
                      else {
                        setState(() {
                          _isSearched = false;
                        });
                      }
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                      labelText: 'Search Here!',
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              print(_controller.text);
                            }),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: _futureAnimeList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.animes.length > 0 && _isSearched)
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            left: BorderSide(
                              color: Colors.black54,
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: Colors.black54,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: Colors.black54,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListView.builder(
                              itemCount: snapshot.data.animes.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          snapshot.data.animes[index].title),
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, bottom: 14, left: 10.0),
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: () => searchMore(),
                                child: Text(
                                  'More results...',
                                  style: TextStyle(
                                    color: Colors.blue[400],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    else
                      return SizedBox.shrink();
                  } else {
                    return SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
    );
  }

  void searchMore() {
    Provider.of<TvSeriesFilterProvider>(context).editFilter(
      false,
      null,
      1,
      _controller.text,
    );
    Navigator.pop(context);
  }
}
