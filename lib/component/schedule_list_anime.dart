import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/schedules_provider.dart';
import 'package:provider/provider.dart';

class ScheduleListAnime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sky.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Text(
              Provider.of<SchedulesProvider>(context).day,
              textAlign: TextAlign.center,
              style: GoogleFonts.alegreya(
                textStyle: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Divider(),
        Container(
          decoration: BoxDecoration(
            // color: Colors.blue[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: FutureBuilder(
            future: Provider.of<SchedulesProvider>(context).futureSchedules,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 16 / 31),
                    itemCount: snapshot.data.day.length,
                    itemBuilder: (context, index) {
                      DateTime parsedAiring =
                          DateTime.parse(snapshot.data.day[index].airingStart);
                      return InkWell(
                        splashColor: Colors.blue[600],
                        onTap: () {
                          Provider.of<AnimeDetailProvider>(context)
                              .setIdAndTitle(
                                  snapshot.data.day[index].malId.toString(),
                                  snapshot.data.day[index].title);
                          Navigator.pushNamed(context, 'detail');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 4.0, left: 4.0, bottom: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[300],
                                Colors.blue[200],
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot.data.day[index].imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  padding: EdgeInsets.symmetric(),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Container(
                                    child: Text(
                                      '   ' +
                                          DateFormat.Hms()
                                              .format(parsedAiring)
                                              .toString() +
                                          ' (JST)   ',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.blue[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img-not-found.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,
                                height: 35,
                                child: ListView.builder(
                                  itemBuilder: (context, indexGenres) =>
                                      Container(
                                    margin: EdgeInsets.all(4),
                                    padding: EdgeInsets.all(2),
                                    color: Colors.white,
                                    child: Text(
                                      snapshot.data.day[index]
                                          .genres[indexGenres].name,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  itemCount:
                                      snapshot.data.day[index].genres.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              Text(
                                snapshot.data.day[index].title + '\n',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.data.day[index].producers.length > 0
                                    ? snapshot
                                        .data
                                        .day[index]
                                        .producers[snapshot.data.day[index]
                                                .producers.length -
                                            1]
                                        .name
                                    : '',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.grey[50], fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {}
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
