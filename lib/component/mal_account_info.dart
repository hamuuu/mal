import 'package:flutter/material.dart';
import 'package:mal/component/chart_stats.dart';
import 'package:url_launcher/url_launcher.dart';

class MalAccountInfo extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;

  const MalAccountInfo({
    Key key,
    this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegExp parseTime = RegExp(r".+?(?=T)");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: snapshot.data.imageUrl != null
                    ? NetworkImage(snapshot.data.imageUrl, scale: 2.2)
                    : NetworkImage(
                        'https://www.publicdomainpictures.net/pictures/280000/nahled/not-found-image-15383864787lu.jpg',
                        scale: 6.3,
                      ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      '${snapshot.data.username}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      //Tanggal

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Joined MAL',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              parseTime
                                  .firstMatch(snapshot.data.joined)
                                  .group(0),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Online',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              parseTime
                                  .firstMatch(snapshot.data.lastOnline)
                                  .group(0),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(width: 1),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Profile URL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                    GestureDetector(
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
                      child: Text(
                        '${snapshot.data.url}',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          color: Colors.blue[400],
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonBar(
                children: [
                  RaisedButton(
                    onPressed: () {
                      _showModalAnimeStatsBottomSheet(context);
                    },
                    child: Text('Anime Stats'),
                    color: Colors.blue,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _showModalMangaStatsBottomSheet(context);
                    },
                    child: Text('Manga Stats'),
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showModalAnimeStatsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return HorizontalBarLabelChart.animeStatsData(snapshot.data.animeStats);
      },
    );
  }

  void _showModalMangaStatsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return HorizontalBarLabelChart.mangaStatsData(snapshot.data.mangaStats);
      },
    );
  }
}
