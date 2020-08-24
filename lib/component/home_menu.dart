import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koukicons/airplay.dart';
import 'package:koukicons/alarm2.dart';
import 'package:koukicons/albumsView.dart';
import 'package:koukicons/cloud.dart';
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Colors.lightBlue[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Text(
                    "Services",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: Colors.lightBlue[50],
            ),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                ServiceButton(
                  koukiconAirplay: KoukiconsAirplay(
                    height: 30,
                  ),
                  label: "TV Series",
                  routeName: "tvSeries",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsMovie2(
                    height: 30,
                  ),
                  label: "Movie",
                  routeName: "movie",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsMultipleDevices(
                    height: 30,
                  ),
                  label: "OVA",
                  routeName: "home",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsCloud(
                    height: 30,
                  ),
                  label: "Season",
                  routeName: "home",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsAlarm2(
                    height: 30,
                  ),
                  label: "Schedule",
                  routeName: "home",
                ),
                ServiceButton(
                  koukiconAirplay: KoukiconsAlbumsView(
                    height: 30,
                  ),
                  label: "Genre",
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
