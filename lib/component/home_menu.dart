import 'package:flutter/material.dart';
import 'package:koukicons/about.dart';
import 'package:koukicons/airplay.dart';
import 'package:koukicons/alarm2.dart';
import 'package:koukicons/albumsView.dart';
import 'package:koukicons/cloud.dart';
import 'package:koukicons/list.dart';
import 'package:koukicons/movie2.dart';
import 'package:koukicons/multipleDevices.dart';
import 'package:mal/component/service_button.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: GridView.count(
              padding: EdgeInsets.all(10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 1,
              children: [
                ServiceButton(
                  koukiconAirplay: KoukiconsAirplay(
                    height: 40,
                  ),
                  label: "TV Series",
                  routeName: "animeList",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsMovie2(
                    height: 40,
                  ),
                  label: "Movie",
                  routeName: "animeList",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsMultipleDevices(
                    height: 40,
                  ),
                  label: "OVA",
                  routeName: "animeList",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsCloud(
                    height: 40,
                  ),
                  label: "Season",
                  routeName: "season",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsAlarm2(
                    height: 40,
                  ),
                  label: "Schedule",
                  routeName: "schedules",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsAlbumsView(
                    height: 40,
                  ),
                  label: "Genre",
                  routeName: "home",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsList(
                    height: 40,
                  ),
                  label: "Library",
                  routeName: "home",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsAbout(
                    height: 40,
                  ),
                  label: "About us",
                  routeName: "home",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
