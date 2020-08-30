import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailAnime extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    Future<Anime> _futureAnimeDetail = Provider.of<AnimeDetailProvider>(context)
        .fetchAnimeDetail(Provider.of<AnimeDetailProvider>(context).id);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Provider.of<AnimeDetailProvider>(context).title,
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 14,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _futureAnimeDetail,
        builder: (context, snapshot) {
          inspect(snapshot.data);
          if (snapshot.hasData) {
            return ListView(
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
                            Text(
                              snapshot.data.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Divider(color: Colors.black54),
                            Text(
                              'Alternative title',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${snapshot.data.titleEnglish} - English',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${snapshot.data.titleJapanese} - Japanese',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
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
                              value: oCcy.format(snapshot.data.scoredBy),
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
                              value: oCcy.format(snapshot.data.members),
                            ),
                            AnimeInfo(
                              desc: 'Favorited by',
                              value: oCcy.format(snapshot.data.favorites),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.black,
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
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
            color: Colors.blue[100],
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
