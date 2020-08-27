import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/star.dart';
import 'package:koukicons/streetName.dart';
import 'package:mal/component/anime_list.dart';
import 'package:mal/providers/tv_series_provider.dart';
import 'package:provider/provider.dart';

class TvSeries extends StatefulWidget {
  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  int _rg = 1;
  String _selectedValue;

  final List<RadioGroup> _filterGroup = [
    RadioGroup(index: 1, text: 'Score'),
    RadioGroup(index: 2, text: 'Title'),
    RadioGroup(index: 3, text: 'Active Members'),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedValue = "Score";
    });
  }

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
                SizedBox(height: 15),
                Text(
                  'List Anime',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tv Series',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
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
                onPressed: () => Navigator.pop(context),
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
                SizedBox(height: 5),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        FlatButton(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            buildShowDialog(context);
                          },
                          splashColor: Colors.grey[600],
                          child: Row(
                            children: [
                              Text(
                                'Order by',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        FlatButton(
                          color: Provider.of<TvSeriesFilterProvider>(context)
                                  .onGoing
                              ? Colors.green[400]
                              : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            Provider.of<TvSeriesFilterProvider>(
                              context,
                            ).editFilter(
                                !Provider.of<TvSeriesFilterProvider>(context)
                                    .onGoing);
                          },
                          splashColor: Colors.grey[600],
                          child: Text(
                            'Ongoing',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(width: 10),
                        FlatButton(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {},
                          splashColor: Colors.grey[600],
                          child: Text(
                            'Studio',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[400], thickness: 1.5, height: 10),
                SizedBox(height: 10),
                AnimeList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    inspect(_selectedValue);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _filterGroup
                      .map(
                        (value) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(value.text),
                                    SizedBox(width: 10),
                                    KoukiconsStar(height: 20),
                                  ],
                                ),
                                Radio(
                                  value: value.index,
                                  groupValue: _rg,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (data) {
                                    setState(() {
                                      _rg = data;
                                      _selectedValue = value.text;
                                    });
                                  },
                                  activeColor: Colors.grey[200],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .toList(),
                );
              },
            ),
          );
        });
  }
}

class RadioGroup {
  final int index;
  final String text;

  RadioGroup({this.index, this.text});
}
