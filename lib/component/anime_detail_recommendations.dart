import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/model/anime_recommend_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_recommend_provider.dart';
import 'package:provider/provider.dart';

class AnimeDetailRecommendations extends StatelessWidget {
  const AnimeDetailRecommendations({Key key, this.futureAnimeRecommendation})
      : super(key: key);
  final futureAnimeRecommendation;

  @override
  Widget build(BuildContext context) {
    Future<AnimeRecommendModel> futureAnimeRecommendation =
        Provider.of<AnimeRecommendProvider>(context).fetchAnimeRecommendation(
            Provider.of<AnimeDetailProvider>(context).id);
    inspect(futureAnimeRecommendation);
    return FutureBuilder(
      future: futureAnimeRecommendation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Our recommendations if you like this Anime',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 0.8),
                ),
                itemCount: snapshot.data.recommendations.length,
                itemBuilder: (context, index) => Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      right: 8.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Provider.of<AnimeDetailProvider>(context).setIdAndTitle(
                            snapshot.data.recommendations[index].malId
                                .toString(),
                            snapshot.data.recommendations[index].title);
                        Navigator.pushNamed(context, 'detail');
                      },
                      splashColor: Colors.blue[400],
                      child: Stack(
                        children: [
                          Container(
                            child: CachedNetworkImage(
                              imageUrl:
                                  snapshot.data.recommendations[index].imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/detail-img-not-found.jpg'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                color: Colors.black45,
                                child: Text(
                                  snapshot.data.recommendations[index].title,
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return StatefulBuilder(
            builder: (context, setState) => Center(
              child: InkWell(
                onTap: () => setState(
                  () => futureAnimeRecommendation =
                      Provider.of<AnimeRecommendProvider>(context)
                          .fetchAnimeRecommendation(
                              Provider.of<AnimeDetailProvider>(context).id),
                ),
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
            ),
          );
        }
        return Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
