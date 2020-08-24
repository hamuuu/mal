import 'dart:developer';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mal/model/mal_account.dart';
import 'package:mal/providers/mal_account_provider.dart';
import 'package:provider/provider.dart';

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelChart(this.seriesList, {this.animate});

  factory HorizontalBarLabelChart.animeStatsData(data) {
    return HorizontalBarLabelChart(
      _createAnimeStatsData(data),
      animate: true,
    );
  }

  factory HorizontalBarLabelChart.mangaStatsData(data) {
    return HorizontalBarLabelChart(
      _createMangaStatsData(data),
      animate: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(seconds: 1),
      behaviors: [
        charts.ChartTitle(
          'Manga Stats from Your MAL Account',
          outerPadding: 20,
          innerPadding: 20,
          titlePadding: 8,
          titleStyleSpec: charts.TextStyleSpec(color: charts.Color.black),
          behaviorPosition: charts.BehaviorPosition.top,
          subTitle: Provider.of<MalAccountProvider>(context).account.username,
        ),
        charts.ChartTitle(
          '',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
      ],
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  static List<charts.Series<AnimeStatsGraph, String>> _createAnimeStatsData(
      AnimeStats value) {
    final data = [
      AnimeStatsGraph('Completed', value.completed,
          charts.MaterialPalette.green.shadeDefault),
      AnimeStatsGraph('Watching', value.watching,
          charts.MaterialPalette.deepOrange.shadeDefault),
      AnimeStatsGraph(
          'On-Hold', value.onHold, charts.MaterialPalette.yellow.shadeDefault),
      AnimeStatsGraph(
          'Dropped', value.dropped, charts.MaterialPalette.red.shadeDefault),
      AnimeStatsGraph('Plan to Watch', value.planToWatch,
          charts.MaterialPalette.gray.shadeDefault),
    ];

    return [
      charts.Series<AnimeStatsGraph, String>(
          id: 'AnimeStats',
          domainFn: (AnimeStatsGraph stats, _) => stats.year,
          measureFn: (AnimeStatsGraph stats, _) => stats.sales,
          data: data,
          colorFn: (AnimeStatsGraph stats, __) => stats.color,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (AnimeStatsGraph sales, _) =>
              '${sales.year}: ${sales.sales.toString()}')
    ];
  }

  static List<charts.Series<AnimeStatsGraph, String>> _createMangaStatsData(
      MangaStats value) {
    final data = [
      AnimeStatsGraph('Completed', value.completed,
          charts.MaterialPalette.green.shadeDefault),
      AnimeStatsGraph('Watching', value.reading,
          charts.MaterialPalette.deepOrange.shadeDefault),
      AnimeStatsGraph(
          'On-Hold', value.onHold, charts.MaterialPalette.yellow.shadeDefault),
      AnimeStatsGraph(
          'Dropped', value.dropped, charts.MaterialPalette.red.shadeDefault),
      AnimeStatsGraph('Plan to Watch', value.planToRead,
          charts.MaterialPalette.gray.shadeDefault),
    ];

    return [
      charts.Series<AnimeStatsGraph, String>(
          id: 'AnimeStats',
          domainFn: (AnimeStatsGraph stats, _) => stats.year,
          measureFn: (AnimeStatsGraph stats, _) => stats.sales,
          data: data,
          colorFn: (AnimeStatsGraph stats, __) => stats.color,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (AnimeStatsGraph sales, _) =>
              '${sales.year}: ${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class AnimeStatsGraph {
  final String year;
  final int sales;
  final color;

  AnimeStatsGraph(this.year, this.sales, this.color);
}
