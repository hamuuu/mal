import 'package:flutter/material.dart';
import 'package:mal/providers/anime_detail_provider.dart';
import 'package:provider/provider.dart';

class AppBarDetailAnime extends StatelessWidget {
  const AppBarDetailAnime({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300], Colors.blue[200]],
            stops: [0.5, 1.0],
          ),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Provider.of<AnimeDetailProvider>(context).title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: false,
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 10, top: 5),
          child: Image(
            image: AssetImage('assets/logo-appbar.png'),
          ),
        )
      ],
      floating: true,
    );
  }
}
