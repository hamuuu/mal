import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/providers/anime_news_provider.dart';
import 'package:mal/providers/news_detail_provider.dart';
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

                  return index > 0
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 3),
                            InkWell(
                              onTap: () {
                                Provider.of<NewsDetailProvider>(context)
                                    .setNews(snapshot.data.articles[index]);
                                Navigator.pushNamed(context, 'detailnews');
                              },
                              splashColor: Colors.blue[400],
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.articles[index].author,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          publishDate,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            snapshot.data.articles[index].title,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            snapshot.data.articles[index]
                                                .description,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                              ),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data.articles[index]
                                                .urlToImage,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Divider(color: Colors.blue[300]),
                            InkWell(
                              onTap: () {
                                Provider.of<NewsDetailProvider>(context)
                                    .setNews(snapshot.data.articles[index]);
                                Navigator.pushNamed(context, 'detailnews');
                              },
                              splashColor: Colors.blue[400],
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot
                                        .data.articles[index].urlToImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        width: double.infinity,
                                        color: Colors.black54,
                                        child: Text(
                                          publishDate,
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
                              ),
                            ),
                            Divider(color: Colors.blue[300])
                          ],
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
