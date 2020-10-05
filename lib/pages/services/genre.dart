import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/providers/genre_anime_list_provider.dart';
import 'package:provider/provider.dart';

class Genre extends StatelessWidget {
  final List<Genres> listGenres = [
    Genres("1", "Action"),
    Genres("2", "Adventure"),
    Genres("3", "Cars"),
    Genres("4", "Comedy"),
    Genres("5", "Dementia"),
    Genres("6", "Demons"),
    Genres("7", "Mystery"),
    Genres("8", "Drama"),
    Genres("9", "Echhi"),
    Genres("10", "Fantasy"),
    Genres("11", "Game"),
    Genres("12", "Hentai"),
    Genres("13", "Historical"),
    Genres("14", "Horror"),
    Genres("15", "Kids"),
    Genres("16", "Magic"),
    Genres("17", "Martial Arts"),
    Genres("18", "Mecha"),
    Genres("19", "Music"),
    Genres("20", "Parody"),
    Genres("21", "Samurai"),
    Genres("22", "Romance"),
    Genres("23", "School"),
    Genres("24", "Sci-Fi"),
    Genres("25", "Shoujo"),
    Genres("26", "Shoujo Ai"),
    Genres("27", "Shounen"),
    Genres("28", "Shounen Ai"),
    Genres("29", "Space"),
    Genres("30", "Sport"),
    Genres("31", "Super Power"),
    Genres("32", "Vampire"),
    Genres("33", "Yaoi"),
    Genres("34", "Yuri"),
    Genres("35", "Harem"),
    Genres("36", "Slice of Life"),
    Genres("37", "Supernatural"),
    Genres("38", "Military"),
    Genres("39", "Police"),
    Genres("40", "Physchological"),
    Genres("41", "Thriller"),
    Genres("42", "Seinen"),
    Genres("43", "Josei"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 14),
                Text(
                  'Genre List',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  color: Colors.grey[200],
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 16 / 7),
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(
                          bottom: 2,
                          right: 2,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Provider.of<GenreAnimeListProvider>(context)
                                  .setKeyAndValue(listGenres[index].key,
                                      listGenres[index].value);
                              Navigator.pushNamed(context, "genreAnimeList");
                            },
                            splashColor: Colors.blue[200],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey[200],
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      listGenres[index].value,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.blue[500],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                      itemCount: listGenres.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Genres {
  String key;
  String value;

  Genres(this.key, this.value);
}
