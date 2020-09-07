import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/calendar.dart';
import 'package:mal/providers/news_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class NewsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic _news = Provider.of<NewsDetailProvider>(context).news;
    var parsedDate = DateTime.parse(_news.publishedAt);
    var publishDate = DateFormat.yMMMd().format(parsedDate);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                flexibleSpace: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CachedFrostedBox(
                        opaqueBackground: Container(),
                        sigmaX: 3.0,
                        sigmaY: 3.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.grey[600],
                                BlendMode.modulate,
                              ),
                              image: NetworkImage(_news.urlToImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // child: Image.network(
                      //   _news.urlToImage,
                      //   fit: BoxFit.cover,
                      //   color: Colors.black87,
                      //   colorBlendMode: BlendMode.color,
                      // ),
                    )
                  ],
                ),
                iconTheme: IconThemeData(color: Colors.white),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: Text(
                        'MAL News',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                    // topRight
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.black),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-1.5, 1.5),
                                    color: Colors.black),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
                toolbarHeight: MediaQuery.of(context).size.height * 0.3,
                automaticallyImplyLeading: false,
                floating: true,
              ),
              SliverToBoxAdapter(
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _news.title,
                              style: GoogleFonts.heebo(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ' ' + publishDate,
                                  style: GoogleFonts.heebo(
                                    textStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 12),
                                  ),
                                ),
                                KoukiconsCalendar(
                                  height: 20,
                                ),
                              ],
                            ),
                            Divider(),
                            Text(
                              _news.content,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        color: Colors.blue[400],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Source : ' + _news.source.name,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Author by',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _news.author,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://www.freepngimg.com/thumb/youtube/62644-profile-account-google-icons-computer-user-iconfinder.png'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
