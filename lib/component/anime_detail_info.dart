import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnimeDetailInfo extends StatelessWidget {
  final snapshot;

  const AnimeDetailInfo({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat("#,##0", "en_US");

    StringBuffer listStudio = StringBuffer();
    StringBuffer listProducer = StringBuffer();
    StringBuffer listLicensor = StringBuffer();
    listToString(snapshot.data.studios, listStudio);

    listToString(snapshot.data.producers, listProducer);

    listToString(snapshot.data.licensors, listLicensor);
    return Column(
      children: [
        SizedBox(height: 20),
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[300],
                  Colors.blue[400],
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Synopsis',
                    style: GoogleFonts.ptSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  Text(
                    snapshot.data.synopsis,
                    style: GoogleFonts.ptSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.black45,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  AnimeInfoList(
                    desc: 'Studios',
                    value: listStudio.toString(),
                  ),
                  Divider(color: Colors.white, thickness: 1),
                  SizedBox(height: 8),
                  AnimeInfoList(
                    desc: 'Licensors',
                    value: listLicensor.toString(),
                  ),
                  Divider(color: Colors.white, thickness: 1),
                  SizedBox(height: 8),
                  AnimeInfoList(
                    desc: 'Producers',
                    value: listProducer.toString(),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          ? oCcy.format(snapshot.data.scoredBy) + ' Users'
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
                          ? oCcy.format(snapshot.data.members) + ' Users'
                          : "null",
                    ),
                    AnimeInfo(
                      desc: 'Favorited by',
                      value: snapshot.data.favorites != null
                          ? oCcy.format(snapshot.data.favorites) + ' Users'
                          : "null",
                    ),
                    AnimeInfo(
                      desc: 'Episodes',
                      value: snapshot.data.episodes.toString() + ' Episode',
                    ),
                    AnimeInfo(
                      desc: 'Type',
                      value: snapshot.data.type.toString(),
                    ),
                    AnimeInfo(
                      desc: 'Duration',
                      value: snapshot.data.duration.toString(),
                    ),
                    AnimeInfo(
                      desc: 'Status',
                      value: snapshot.data.status.toString(),
                    ),
                    AnimeInfo(
                      desc: 'Premiered',
                      value: snapshot.data.premiered.toString(),
                    ),
                    AnimeInfo(
                      desc: 'Source',
                      value: snapshot.data.source.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
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
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue[400],
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue[300],
                Colors.blue[400],
              ],
            ),
          ),
          constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 35,
          ),
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
            constraints: BoxConstraints(
              minHeight: 35,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue[400],
              ),
            ),
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value != "null" ? value : '-',
                  style: GoogleFonts.anton(
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimeInfoList extends StatelessWidget {
  const AnimeInfoList({
    Key key,
    @required this.desc,
    @required this.value,
  }) : super(key: key);

  final String desc;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 100,
          child: Text(
            desc,
            style: GoogleFonts.ptSerif(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value != "null" ? value : '-',
            style: GoogleFonts.ptSerif(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
