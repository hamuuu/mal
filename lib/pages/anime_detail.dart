import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailAnime extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    Future<Anime> _futureAnimeDetail = Provider.of<AnimeDetailProvider>(context)
        .fetchAnimeDetail(Provider.of<AnimeDetailProvider>(context).id);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Text(
                Provider.of<AnimeDetailProvider>(context).title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
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
          child: FutureBuilder(
            future: _futureAnimeDetail,
            builder: (context, snapshot) {
              inspect(snapshot.data);
              StringBuffer listGenre = StringBuffer();
              StringBuffer listStudio = StringBuffer();

              if (snapshot.hasData) {
                listToString(snapshot.data.genres, listGenre);
                listToString(snapshot.data.studios, listStudio);
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      snapshot.data.imageUrl,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    child: Text(
                                      snapshot.data.title,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Divider(color: Colors.black54),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue[500],
                                          Colors.blue[300],
                                        ],
                                      ),
                                    ),
                                    constraints: BoxConstraints(
                                      minHeight: 150,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Alternative title',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Divider(color: Colors.white70),
                                          snapshot.data.titleEnglish != null
                                              ? Text(
                                                  '${snapshot.data.titleEnglish} - English',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(height: 10),
                                          snapshot.data.titleJapanese != null
                                              ? Text(
                                                  '${snapshot.data.titleJapanese} - Japanese',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AnimeInfo(
                                  desc: 'Score',
                                  value: snapshot.data.score.toString(),
                                ),
                                AnimeInfo(
                                  desc: 'Scored by',
                                  value: snapshot.data.scoredBy != null
                                      ? oCcy.format(snapshot.data.scoredBy)
                                      : "null",
                                ),
                                AnimeInfo(
                                  desc: 'Rank',
                                  value: snapshot.data.rank.toString(),
                                ),
                                AnimeInfo(
                                  desc: 'Popularity',
                                  value: snapshot.data.popularity.toString(),
                                ),
                                AnimeInfo(
                                  desc: 'Members',
                                  value: snapshot.data.members != null
                                      ? oCcy.format(snapshot.data.members)
                                      : "null",
                                ),
                                AnimeInfo(
                                  desc: 'Favorited by',
                                  value: snapshot.data.favorites != null
                                      ? oCcy.format(snapshot.data.favorites)
                                      : "null",
                                ),
                                AnimeInfo(
                                  desc: 'Episodes',
                                  value: snapshot.data.episodes.toString(),
                                ),
                                AnimeInfo(
                                  desc: 'Type',
                                  value: snapshot.data.type,
                                ),
                                AnimeInfo(
                                  desc: 'Duration',
                                  value: snapshot.data.duration,
                                ),
                                AnimeInfo(
                                  desc: 'Status',
                                  value: snapshot.data.status,
                                ),
                                AnimeInfo(
                                  desc: 'Premiered',
                                  value: snapshot.data.premiered,
                                ),
                                AnimeInfo(
                                  desc: 'Source',
                                  value: snapshot.data.source,
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () async {
                                    if (await canLaunch(snapshot.data.url)) {
                                      await launch(
                                        snapshot.data.url,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'Couldn\'t launch';
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Visit Page in MAL',
                                        style: TextStyle(
                                          color: Colors.blue[400],
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.blue[400],
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[500],
                              Colors.blue[300],
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Genres',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      listGenre.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Studios',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      listStudio.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueGrey[400],
                              Colors.blue[300],
                            ],
                          ),
                        ),
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        )
      ]),
    );
  }

  void listToString(list, string) {
    list.asMap().forEach((index, item) {
      index != list.length - 1
          ? string.write(item.name + ', ')
          : string.write(item.name);
    });
  }
}

class AnimeInfo extends StatelessWidget {
  const AnimeInfo({
    Key key,
    @required this.desc,
    @required this.value,
  }) : super(key: key);

  final String desc;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue[400],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              desc,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value != "null" ? value : '-',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
