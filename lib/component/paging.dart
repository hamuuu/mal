import 'package:flutter/material.dart';
import 'package:mal/providers/tv_series_provider.dart';
import 'package:provider/provider.dart';

class Paging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        Provider.of<TvSeriesFilterProvider>(context).page >= 3
            ? FlatButton(
                color: Colors.grey[400],
                onPressed: () {
                  Provider.of<TvSeriesFilterProvider>(context).editFilter(
                      Provider.of<TvSeriesFilterProvider>(context).onGoing,
                      Provider.of<TvSeriesFilterProvider>(context).orderBy,
                      1,
                      Provider.of<TvSeriesFilterProvider>(context).query);
                },
                child: Text(
                  "First Page",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            : null,
        Provider.of<TvSeriesFilterProvider>(context).page != 1
            ? RaisedButton(
                color: Colors.blue[400],
                onPressed: () {
                  Provider.of<TvSeriesFilterProvider>(context).editFilter(
                      Provider.of<TvSeriesFilterProvider>(context).onGoing,
                      Provider.of<TvSeriesFilterProvider>(context).orderBy,
                      Provider.of<TvSeriesFilterProvider>(context).page - 1,
                      Provider.of<TvSeriesFilterProvider>(context).query);
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
            Provider.of<TvSeriesFilterProvider>(context).editFilter(
                Provider.of<TvSeriesFilterProvider>(context).onGoing,
                Provider.of<TvSeriesFilterProvider>(context).orderBy,
                Provider.of<TvSeriesFilterProvider>(context).page + 1,
                Provider.of<TvSeriesFilterProvider>(context).query);
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
