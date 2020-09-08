import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/component/app_bar_detail_anime.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_review_provider.dart';
import 'package:mal/model/anime_review_model.dart';
import 'package:provider/provider.dart';
import 'package:mal/component/spider_chart.dart';
import 'package:readmore/readmore.dart';

class AnimeReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<ReviewAnime> _futureReviewAnime =
        Provider.of<AnimeReviewProvider>(context)
            .fetchAnimeReview(Provider.of<AnimeDetailProvider>(context).id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarDetailAnime(),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: _futureReviewAnime,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.reviews.length,
                      itemBuilder: (context, index) {
                        var parsedDate =
                            DateTime.parse(snapshot.data.reviews[index].date);
                        var publishDate = DateFormat.yMMMd().format(parsedDate);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                left: 8.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 2,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data.reviews[index]
                                                  .reviewer.imageUrl,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.14,
                                          child: SpiderChart(
                                            data: [
                                              snapshot
                                                      .data
                                                      .reviews[index]
                                                      .reviewer
                                                      .scores
                                                      .animation +
                                                  .0,
                                              snapshot
                                                      .data
                                                      .reviews[index]
                                                      .reviewer
                                                      .scores
                                                      .character +
                                                  .0,
                                              snapshot
                                                      .data
                                                      .reviews[index]
                                                      .reviewer
                                                      .scores
                                                      .enjoyment +
                                                  .0,
                                              snapshot.data.reviews[index]
                                                      .reviewer.scores.sound +
                                                  .0,
                                              snapshot.data.reviews[index]
                                                      .reviewer.scores.story +
                                                  .0,
                                            ],
                                            maxValue: 10,
                                            labels: [
                                              'Animation',
                                              'Character',
                                              'Enjoyment',
                                              'Sound',
                                              'Story',
                                            ],
                                            colors: <Color>[
                                              Colors.red,
                                              Colors.green,
                                              Colors.blue,
                                              Colors.yellow,
                                              Colors.indigo,
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        // Text(
                                        //   'Overall Rating : ${snapshot.data.reviews[index].reviewer.scores.overall}',
                                        //   style: GoogleFonts.poppins(
                                        //     textStyle: TextStyle(
                                        //       color: Colors.black54,
                                        //       fontSize: 12,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data.reviews[index].reviewer
                                            .username,
                                        style: GoogleFonts.notoSans(
                                          textStyle: TextStyle(
                                            color: Colors.blue[400],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.reviews[index]
                                                .helpfulCount
                                                .toString() +
                                            ' people found this review helpful',
                                        style: GoogleFonts.robotoCondensed(
                                          textStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        publishDate,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 10,
                                          textStyle: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.reviews[index].reviewer.episodesSeen} of ${Provider.of<AnimeReviewProvider>(context).episode} episodes seen',
                                        style: GoogleFonts.robotoCondensed(
                                          textStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  ReadMoreText(
                                    snapshot.data.reviews[index].content
                                        .replaceAll(RegExp(r'\\n'), ''),
                                    style: GoogleFonts.bitter(
                                      textStyle: TextStyle(
                                          color: Colors.black87, fontSize: 12),
                                    ),
                                    trimExpandedText: ' Read less..',
                                    trimCollapsedText: ' Read more..',
                                    trimMode: TrimMode.Length,
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Divider(color: Colors.black87),
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, 'review'),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Failed to load data. Click here to reload',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              KoukiconsSynchronize(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
