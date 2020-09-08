import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/search.dart';
import 'package:koukicons/star.dart';
import 'package:koukicons/streetName.dart';
import 'package:mal/component/search_bar.dart';
import 'package:mal/providers/anime_list_provider.dart';
import 'package:provider/provider.dart';

class FliterBarButton extends StatefulWidget {
  @override
  _FliterBarButtonState createState() => _FliterBarButtonState();
}

class _FliterBarButtonState extends State<FliterBarButton> {
  int _rg = -1;
  String _activatedOrderBy;

  final List<RadioGroup> _filterGroup = [
    RadioGroup(index: 1, text: 'Score', icon: KoukiconsStar(height: 35)),
    RadioGroup(index: 2, text: 'Title', icon: KoukiconsStreetName(height: 35)),
    RadioGroup(
        index: 3,
        text: 'Active Members',
        icon: KoukiconsBusinessman(height: 35)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              FlatButton(
                color: _activatedOrderBy != null
                    ? Colors.green[400]
                    : Colors.grey[400],
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
                      _activatedOrderBy == null
                          ? 'Order by'
                          : 'Order by $_activatedOrderBy',
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
                color: Provider.of<ListAnimeFilterProvider>(context).onGoing
                    ? Colors.green[400]
                    : Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Provider.of<ListAnimeFilterProvider>(
                    context,
                  ).editFilter(
                      !Provider.of<ListAnimeFilterProvider>(context).onGoing,
                      Provider.of<ListAnimeFilterProvider>(context).orderBy,
                      1,
                      Provider.of<ListAnimeFilterProvider>(context).query);
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
            ],
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color:
                    Provider.of<ListAnimeFilterProvider>(context).query != null
                        ? Colors.green[400]
                        : Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.search),
              ),
            ),
            onTap: () {
              Provider.of<ListAnimeFilterProvider>(context).query != null
                  ? Provider.of<ListAnimeFilterProvider>(context).removeSearch()
                  : Navigator.of(context).push(_buildSearchPage(context));
            },
            splashColor: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Route _buildSearchPage(BuildContext context) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SearchBar(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose your list order',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: _filterGroup
                          .map(
                            (value) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(value.text),
                                        SizedBox(width: 10),
                                        value.icon,
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
                                          Provider.of<ListAnimeFilterProvider>(
                                                  context)
                                              .editFilter(
                                                  Provider.of<ListAnimeFilterProvider>(
                                                          context)
                                                      .onGoing,
                                                  value.text,
                                                  1,
                                                  Provider.of<ListAnimeFilterProvider>(
                                                          context)
                                                      .query);
                                          _activatedOrderBy = value.text;
                                        });
                                        Navigator.pop(context);
                                      },
                                      activeColor: Colors.blue[500],
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 7,
                                  color: Colors.grey[400],
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 20)
                  ],
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
  final Object icon;

  RadioGroup({this.index, this.icon, this.text});
}
