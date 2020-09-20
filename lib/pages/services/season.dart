import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/model/anime_season_list.dart';
import 'package:mal/model/season_archive_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_season_list_provider.dart';
import 'package:mal/providers/season_archive_provider.dart';
import 'package:provider/provider.dart';

class SeasonList extends StatefulWidget {
  @override
  _SeasonListState createState() => _SeasonListState();
}

class _SeasonListState extends State<SeasonList> {
  @override
  Widget build(BuildContext context) {
    Future<AnimeSeasonListModel> _futureAnimeSeasonList =
        Provider.of<AnimeSeasonListProvider>(context).fetchAnimeSeasonList(
            Provider.of<AnimeSeasonListProvider>(context).year,
            Provider.of<AnimeSeasonListProvider>(context).season);

    Future<SeasonArchiveModel> _futureSeasonArchive =
        Provider.of<SeasonArchiveProvider>(context).fetchSeasonArchive();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 22),
                Text(
                  'Seasonal Anime',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
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
            child: Column(
              children: [
                SizedBox(height: 10),
                FutureBuilder(
                  future: _futureSeasonArchive,
                  builder: (context, snapshot) {
                    String tempYear =
                        Provider.of<AnimeSeasonListProvider>(context).year;
                    String tempSeason =
                        Provider.of<AnimeSeasonListProvider>(context).season;

                    if (snapshot.hasData) {
                      List<String> valueYear = List<String>();
                      for (var i = 0; i < snapshot.data.archive.length; i++) {
                        valueYear.add(snapshot.data.archive[i].year.toString());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomRadioButton(
                              elevation: 0,
                              absoluteZeroSpacing: false,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: valueYear,
                              buttonValues: valueYear,
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              defaultSelected:
                                  Provider.of<AnimeSeasonListProvider>(context)
                                      .year,
                              radioButtonValue: (value) {
                                tempYear = value;
                              },
                              enableShape: false,
                              selectedColor: Colors.green[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomRadioButton(
                              elevation: 0,
                              absoluteZeroSpacing: false,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: [
                                "Winter",
                                "Spring",
                                "Summer",
                                "Fall"
                              ],
                              buttonValues: [
                                "Winter",
                                "Spring",
                                "Summer",
                                "Fall"
                              ],
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              radioButtonValue: (value) {
                                tempSeason = value;
                              },
                              defaultSelected:
                                  Provider.of<AnimeSeasonListProvider>(context)
                                      .season,
                              enableShape: false,
                              selectedColor: Colors.green[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 5.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  splashColor: Colors.blue[600],
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue[600],
                                    ),
                                    child: Text(
                                      'Set',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (tempYear != null &&
                                        tempSeason != null) {
                                      Provider.of<AnimeSeasonListProvider>(
                                              context)
                                          .setYearAndSeason(
                                              tempYear, tempSeason);
                                    }
                                  },
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Divider(color: Colors.black54),
                FutureBuilder(
                  future: _futureAnimeSeasonList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                snapshot.data.seasonName +
                                    ', ' +
                                    snapshot.data.seasonYear.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GridView.builder(
                                itemCount: 20,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1 / 1.5),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8.0, bottom: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Provider.of<AnimeDetailProvider>(
                                                context)
                                            .setIdAndTitle(
                                                snapshot.data.anime[index].malId
                                                    .toString(),
                                                snapshot
                                                    .data.anime[index].title);
                                        Navigator.pushNamed(context, 'detail');
                                      },
                                      splashColor: Colors.blue[400],
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.anime[index].imageUrl,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
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
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  snapshot
                                                      .data.anime[index].title,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, 'season'),
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
                      );
                    }
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
