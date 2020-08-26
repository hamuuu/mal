import 'dart:convert';
import 'dart:developer';

import 'package:koukicons/star.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AnimeList extends StatefulWidget {
  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  Future<AnimeListModel> futureAnimeList;
  Future<AnimeListModel> fetchAnimeList() async {
    String url =
        'http://api.jikan.moe/v3/search/anime?order_by=score&type=tv&page=1&limit=10';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAnimeList = fetchAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    RegExp parseTime = RegExp(r".+?(?=T)");
    final DateFormat formatter = DateFormat('MMM, yyyy');

    return FutureBuilder(
      future: futureAnimeList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          inspect(snapshot.data);
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: snapshot.data.animes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image(
                              image: NetworkImage(
                                snapshot.data.animes[index].imageUrl,
                                scale: 2,
                              ),
                            ),
                            Container(
                              color: Colors.blue[600],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.animes[index].type,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data.animes[index].title}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  KoukiconsStar(height: 12),
                                  Text(
                                    snapshot.data.animes[index].score
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data.animes[index].rated,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '${formatter.format(DateTime.parse(parseTime.firstMatch(snapshot.data.animes[index].startDate).group(0)))} - ${formatter.format(DateTime.parse(parseTime.firstMatch(snapshot.data.animes[index].endDate).group(0)))}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data.animes[index].synopsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Click here for more',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue[300],
                                    decoration: TextDecoration.underline,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    )
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          throw Exception(snapshot.error);
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}