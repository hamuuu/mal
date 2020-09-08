import 'dart:developer';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:mal/model/anime_recommend_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_recommend_provider.dart';
import 'package:mal/providers/anime_review_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailAnime extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    Future<Anime> _futureAnimeDetail = Provider.of<AnimeDetailProvider>(context)
        .fetchAnimeDetail(Provider.of<AnimeDetailProvider>(context).id);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[300], Colors.blue[200]],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                centerTitle: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Provider.of<AnimeDetailProvider>(context).title,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                automaticallyImplyLeading: false,
                actions: [
                  Container(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Image(
                      image: AssetImage('assets/logo-appbar.png'),
                    ),
                  )
                ],
                floating: true,
              ),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: _futureAnimeDetail,
                  builder: (context, snapshot) {
                    StringBuffer listStudio = StringBuffer();
                    StringBuffer listProducer = StringBuffer();
                    StringBuffer listLicensor = StringBuffer();

                    if (snapshot.hasData) {
                      listToString(snapshot.data.studios, listStudio);

                      listToString(snapshot.data.producers, listProducer);

                      listToString(snapshot.data.licensors, listLicensor);

                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Stack(
                              children: [
                                CachedFrostedBox(
                                  opaqueBackground: Container(),
                                  sigmaX: 3.0,
                                  sigmaY: 3.0,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.imageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey[600],
                                            BlendMode.modulate,
                                          ),
                                          image: NetworkImage(
                                              snapshot.data.imageUrl),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
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
                                Positioned(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  top: 60,
                                  left: MediaQuery.of(context).size.width * 0.3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue[400],
                                        style: BorderStyle.solid,
                                        width: 2,
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data.imageUrl,
                                      imageBuilder: (context, imageProvider) =>
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
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  snapshot.data.title,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 5),
                              snapshot.data.titleEnglish != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        snapshot.data.titleEnglish,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: 5),
                              snapshot.data.titleJapanese != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        snapshot.data.titleJapanese,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  children: snapshot.data.genres
                                      .map<Widget>(
                                        (genre) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                            vertical: 3,
                                          ),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey[600],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  genre.name,
                                                  style: GoogleFonts.dosis(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                          Divider(),
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
                          Divider(),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      AnimeInfo(
                                        desc: 'Score',
                                        value: snapshot.data.score.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Scored by',
                                        value: snapshot.data.scoredBy != null
                                            ? oCcy.format(
                                                    snapshot.data.scoredBy) +
                                                ' Users'
                                            : "null",
                                      ),
                                      AnimeInfo(
                                        desc: 'Rank',
                                        value: snapshot.data.rank.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Popularity',
                                        value:
                                            snapshot.data.popularity.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Members',
                                        value: snapshot.data.members != null
                                            ? oCcy.format(
                                                    snapshot.data.members) +
                                                ' Users'
                                            : "null",
                                      ),
                                      AnimeInfo(
                                        desc: 'Favorited by',
                                        value: snapshot.data.favorites != null
                                            ? oCcy.format(
                                                    snapshot.data.favorites) +
                                                ' Users'
                                            : "null",
                                      ),
                                      AnimeInfo(
                                        desc: 'Episodes',
                                        value:
                                            snapshot.data.episodes.toString() +
                                                ' Episode',
                                      ),
                                      AnimeInfo(
                                        desc: 'Type',
                                        value: snapshot.data.type.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Duration',
                                        value:
                                            snapshot.data.duration.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Status',
                                        value: snapshot.data.status.toString(),
                                      ),
                                      AnimeInfo(
                                        desc: 'Premiered',
                                        value:
                                            snapshot.data.premiered.toString(),
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
                          SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 80),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
          FutureBuilder(
              future: _futureAnimeDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: new Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: RaisedButton(
                              color: Colors.pink[400],
                              child: Text(
                                'Review',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              splashColor: Colors.pink[300],
                              onPressed: () {
                                Provider.of<AnimeReviewProvider>(context)
                                    .setEpisode(
                                        snapshot.data.episodes.toString());
                                Navigator.pushNamed(context, 'review');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0),
                                  side: BorderSide(color: Colors.white70)),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: RaisedButton(
                              color: Colors.pink[400],
                              child: Text(
                                'Recommendation',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _buildModalBottomSheet(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0),
                                  side: BorderSide(color: Colors.white70)),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
        ],
      ),
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

void _buildModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      Future<AnimeRecommendModel> _futureAnimeRecommendation =
          Provider.of<AnimeRecommendProvider>(context).fetchAnimeRecommendation(
              Provider.of<AnimeDetailProvider>(context).id);
      return FutureBuilder(
        future: _futureAnimeRecommendation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
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
                                Provider.of<AnimeDetailProvider>(context)
                                    .setIdAndTitle(
                                        snapshot
                                            .data.recommendations[index].malId
                                            .toString(),
                                        snapshot
                                            .data.recommendations[index].title);
                                Navigator.pushNamed(context, 'detail');
                              },
                              splashColor: Colors.blue[400],
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(snapshot.data
                                            .recommendations[index].imageUrl),
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
                                          snapshot.data.recommendations[index]
                                              .title,
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
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Our recommendation if you like this anime',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSansCondensed(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    color: Colors.blue[400],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return StatefulBuilder(
              builder: (context, setState) => Center(
                child: InkWell(
                  onTap: () => setState(
                    () => _futureAnimeRecommendation =
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
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    },
  );
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

class CachedFrostedBox extends StatefulWidget {
  CachedFrostedBox(
      {@required this.child,
      this.sigmaX = 8,
      this.sigmaY = 8,
      this.opaqueBackground})
      : this.frostBackground = Stack(
          children: <Widget>[
            opaqueBackground,
            ClipRect(
                child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: new Container(
                  decoration: new BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              )),
            )),
          ],
        );

  final Widget child;
  final double sigmaY;
  final double sigmaX;

  /// This must be opaque so the backdrop filter won't access any colors beneath this background.
  final Widget opaqueBackground;

  /// Blur applied to the opaqueBackground. See the constructor.
  final Widget frostBackground;

  @override
  State<StatefulWidget> createState() {
    return CachedFrostedBoxState();
  }
}

class CachedFrostedBoxState extends State<CachedFrostedBox> {
  final GlobalKey _snapshotKey = GlobalKey();

  Image _backgroundSnapshot;
  bool _snapshotLoaded = false;
  bool _skipSnapshot = false;

  void _snapshot(Duration _) async {
    final RenderRepaintBoundary renderBackground =
        _snapshotKey.currentContext.findRenderObject();
    final ui.Image image = await renderBackground.toImage(
      pixelRatio: WidgetsBinding.instance.window.devicePixelRatio,
    );
    // !!! The default encoding rawRgba will throw exceptions. This bug is introducing a lot
    // of encoding/decoding work.
    final ByteData imageByteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      _backgroundSnapshot = Image.memory(imageByteData.buffer.asUint8List());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget frostedBackground;
    if (_backgroundSnapshot == null || _skipSnapshot) {
      frostedBackground = RepaintBoundary(
        key: _snapshotKey,
        child: widget.frostBackground,
      );
      if (!_skipSnapshot) {
        SchedulerBinding.instance.addPostFrameCallback(_snapshot);
      }
    } else {
      // !!! We don't seem to have a way to know when IO thread
      // decoded the image.
      if (!_snapshotLoaded) {
        frostedBackground = widget.frostBackground;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _snapshotLoaded = true;
          });
        });
      } else {
        frostedBackground = Offstage();
      }
    }

    return Stack(
      children: <Widget>[
        frostedBackground,
        if (_backgroundSnapshot != null) _backgroundSnapshot,
        widget.child,
        GestureDetector(onTap: () {
          setState(() {
            _skipSnapshot = !_skipSnapshot;
          });
        }),
      ],
    );
  }
}
