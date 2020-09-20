import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/component/schedule_list_anime.dart';
import 'package:mal/component/schedule_list_days.dart';
import 'package:mal/providers/schedules_provider.dart';
import 'package:provider/provider.dart';

class Schedules extends StatelessWidget {
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
                SizedBox(height: 22),
                Text(
                  'Schedules of the week Anime',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),
                ScheduleListDays(),
                Divider(),
                Provider.of<SchedulesProvider>(context).futureSchedules == null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Text(
                          "Choose the day and see what's airing!",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.blue[400],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : ScheduleListAnime(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
