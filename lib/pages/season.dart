import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/synchronize.dart';
import 'package:mal/model/anime_season_list.dart';
import 'package:mal/providers/anime_season_list_provider.dart';
import 'package:provider/provider.dart';

class SeasonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<AnimeSeasonListModel> _futureAnimeSeasonList =
        Provider.of<AnimeSeasonListProvider>(context).fetchAnimeSeasonList();
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        // color: _activatedOrderBy != null
                        //     ? Colors.green[400]
                        //     : Colors.grey[400],
                        onTap: () {},
                        splashColor: Colors.grey[600],
                        child: Row(
                          children: [
                            Text(
                              'Year',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.grey[600],
                        child: Row(
                          children: [
                            Text(
                              'Season',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black54),
                FutureBuilder(
                  future: _futureAnimeSeasonList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
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
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data.anime[index].imageUrl),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, 'season'),
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
