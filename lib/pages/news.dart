import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/providers/anime_news_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AnimeNewsProvider>(context).futureAnimeNews,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var parsedDate =
                      DateTime.parse(snapshot.data.articles[index].publishedAt);
                  var publishDate = DateFormat.yMMMd().format(parsedDate);
                  inspect(publishDate);

                  return index > 0
                      ? Column(
                          children: [
                            SizedBox(height: 3),
                            Card(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: Image(
                                        image: NetworkImage(
                                          snapshot
                                              .data.articles[index].urlToImage,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data.articles[index].urlToImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.black54,
                                  child: Text(
                                    '${snapshot.data.articles[index].title} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: double.infinity,
                                  color: Colors.black54,
                                  child: Text(
                                    '${publishDate} ',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        );
                },
                itemCount: snapshot.data.articles.length,
              )
            : Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  CircularProgressIndicator(),
                ],
              );
      },
    );
  }
}
