import 'package:flutter/material.dart';
import 'package:mal/providers/anime_list_provider.dart';
import 'package:provider/provider.dart';

class Paging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        Provider.of<ListAnimeFilterProvider>(context).page >= 3
            ? FlatButton(
                color: Colors.grey[400],
                onPressed: () {
                  Provider.of<ListAnimeFilterProvider>(context).editFilter(
                      Provider.of<ListAnimeFilterProvider>(context).onGoing,
                      Provider.of<ListAnimeFilterProvider>(context).orderBy,
                      1,
                      Provider.of<ListAnimeFilterProvider>(context).query);
                },
                child: Text(
                  "First Page",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            : null,
        Provider.of<ListAnimeFilterProvider>(context).page != 1
            ? RaisedButton(
                color: Colors.blue[400],
                onPressed: () {
                  Provider.of<ListAnimeFilterProvider>(context).editFilter(
                      Provider.of<ListAnimeFilterProvider>(context).onGoing,
                      Provider.of<ListAnimeFilterProvider>(context).orderBy,
                      Provider.of<ListAnimeFilterProvider>(context).page - 1,
                      Provider.of<ListAnimeFilterProvider>(context).query);
                },
                child: Text(
                  "Prev 50",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              )
            : null,
        RaisedButton(
          color: Colors.blue[400],
          onPressed: () {
            Provider.of<ListAnimeFilterProvider>(context).editFilter(
                Provider.of<ListAnimeFilterProvider>(context).onGoing,
                Provider.of<ListAnimeFilterProvider>(context).orderBy,
                Provider.of<ListAnimeFilterProvider>(context).page + 1,
                Provider.of<ListAnimeFilterProvider>(context).query);
          },
          child: Text(
            "Next 50",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
