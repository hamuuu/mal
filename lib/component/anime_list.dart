import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/star.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/component/paging.dart';
import 'package:mal/model/anime_list_model.dart';
import 'package:flutter/material.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_list_provider.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatefulWidget {
  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  @override
  Widget build(BuildContext context) {
    Future<AnimeListModel> _futureAnimeList =
        Provider.of<ListAnimeFilterProvider>(context).fetchAnimeList(
      Provider.of<ListAnimeFilterProvider>(context).onGoing,
      Provider.of<ListAnimeFilterProvider>(context).orderBy,
      Provider.of<ListAnimeFilterProvider>(context).query,
    );
    return FutureBuilder(
      future: _futureAnimeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ListView.builder(
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
                                  // Image(
                                  //   image: NetworkImage(
                                  //     snapshot.data.animes[index].imageUrl,
                                  //     scale: 2,
                                  //   ),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        snapshot.data.animes[index].imageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.34,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.34,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
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
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<AnimeDetailProvider>(context)
                                        .setIdAndTitle(
                                            snapshot.data.animes[index].malId
                                                .toString(),
                                            snapshot.data.animes[index].title);
                                    Navigator.pushNamed(context, 'detail');
                                  },
                                  splashColor: Colors.blue[400],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      SizedBox(height: 5),
                                      Text(
                                        snapshot.data.animes[index].rated !=
                                                null
                                            ? snapshot.data.animes[index].rated
                                            : '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red[400],
                                        ),
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
                                      Text(
                                        'Click here for more',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blue[300],
                                          decoration: TextDecoration.underline,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                    ],
                                  ),
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
                ),
                Paging(),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: InkWell(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, 'animeList'),
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
