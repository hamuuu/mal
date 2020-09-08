import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/model/weather_report_model.dart';
import 'package:mal/providers/anime_news_provider.dart';
import 'package:mal/providers/news_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Position _currentPosition;
  String _currentCity;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Future<WeatherReport> _futureWeatherReport;

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentCity = "${place.administrativeArea}";
      });
      _futureWeatherReport = Provider.of<AnimeNewsProvider>(context)
          .fetchWeatherReport(place.administrativeArea);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yMMMMd');
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
                                    CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data.articles[index].urlToImage,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: imageProvider,
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                      ),
                                      placeholder: (context, url) => Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/img-not-found.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    snapshot.data.articles[index].urlToImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
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
                                placeholder: (context, url) => Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img-not-found.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MAL News',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.blue[400],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Your credentials daily news',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.blue[300],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        formatter
                                            .format(DateTime.now())
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.blue[300],
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder(
                                      future: _futureWeatherReport,
                                      builder: (context, snapshot) {
                                        inspect(snapshot);
                                        if (snapshot.hasData) {
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _currentCity,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    color: Colors.blue[400],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 26,
                                                    backgroundColor:
                                                        Colors.blue[400],
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data
                                                              .current
                                                              .weatherIcons[0]),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data.current
                                                        .weatherDescriptions[0],
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        color: Colors.blue[300],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data.current
                                                        .temperature
                                                        .toString() +
                                                    ' °C',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    color: Colors.red[800],
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          Text(snapshot.error);
                                        }
                                        return SizedBox.shrink();
                                      })
                                ],
                              ),
                            ),
                            Divider(color: Colors.blue[300]),
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
