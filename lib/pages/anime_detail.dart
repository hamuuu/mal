import 'dart:developer';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/bookmarkC.dart';
import 'package:koukicons/comments.dart';
import 'package:koukicons/info.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/component/anime_detail_info.dart';
import 'package:mal/component/anime_detail_recommendations.dart';
import 'package:mal/component/anime_detail_review.dart';
import 'package:mal/model/anime_detail_model.dart';
import 'package:mal/model/anime_recommend_model.dart';
import 'package:mal/model/anime_review_model.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:mal/providers/anime_recommend_provider.dart';
import 'package:mal/providers/anime_review_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailAnime extends StatefulWidget {
  @override
  _DetailAnimeState createState() => _DetailAnimeState();
}

class _DetailAnimeState extends State<DetailAnime>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _tabIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this)
      ..addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        _tabIndex = _controller.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Anime> _futureAnimeDetail = Provider.of<AnimeDetailProvider>(context)
        .fetchAnimeDetail(Provider.of<AnimeDetailProvider>(context).id);

    return Scaffold(
      body: CustomScrollView(
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
              icon: Icon(Icons.keyboard_arrow_left),
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
                if (snapshot.hasData) {
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
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.grey[600],
                                        BlendMode.modulate,
                                      ),
                                      image: imageProvider,
                                      fit: BoxFit.fitWidth,
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
                            Positioned(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                            padding: const EdgeInsets.all(5.0),
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          controller: _controller,
                          tabs: [
                            Tab(
                              child: Row(
                                children: [
                                  KoukiconsInfo(
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Info',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.blue[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [
                                  KoukiconsComments(
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Reviews',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.blue[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [
                                  KoukiconsBookmarkC(
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Recommendations',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.blue[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      [
                        AnimeDetailInfo(snapshot: snapshot),
                        AnimeDetailReview(),
                        AnimeDetailRecommendations(),
                      ][_tabIndex],
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
