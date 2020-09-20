import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/providers/schedules_provider.dart';
import 'package:provider/provider.dart';

class ScheduleListDays extends StatelessWidget {
  const ScheduleListDays({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.163,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          children: [
            DayWidget(
              assets: 'assets/day_icon/sunday.png',
              day: 'Sunday',
            ),
            DayWidget(
              assets: 'assets/day_icon/monday.png',
              day: 'Monday',
            ),
            DayWidget(
              assets: 'assets/day_icon/tuesday.png',
              day: 'Tuesday',
            ),
            DayWidget(
              assets: 'assets/day_icon/wednesday.png',
              day: 'Wednesday',
            ),
            DayWidget(
              assets: 'assets/day_icon/thursday.png',
              day: 'Thursday',
            ),
            DayWidget(
              assets: 'assets/day_icon/friday.png',
              day: 'Friday',
            ),
            DayWidget(
              assets: 'assets/day_icon/saturday.png',
              day: 'Saturday',
            ),
          ],
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final String assets;
  final String day;

  const DayWidget({Key key, @required this.assets, @required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<SchedulesProvider>(context).setFutureSchedules(day);
      },
      splashColor: Colors.blue,
      child: Container(
        decoration: BoxDecoration(
          color: Provider.of<SchedulesProvider>(context).day != day
              ? Colors.transparent
              : Colors.blue[600],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(assets), fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              child: Text(
                day,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
