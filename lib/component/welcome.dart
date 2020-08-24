import 'package:flutter/material.dart';
import 'package:koukicons/settings10.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[200],
              Colors.blue[500],
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              KoukiconsSettings10(
                height: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'This App is Powered by Jikan API',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'All of the data reserved to MyAnimeList',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'For more information visit jikan.moe documentations',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Learn More',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
