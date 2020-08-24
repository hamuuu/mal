import 'dart:developer';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mal/component/mal_account_info.dart';
import 'package:mal/model/mal_account.dart';
import 'package:mal/providers/auth.dart';
import 'package:mal/providers/mal_account_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final String url = "https://api.jikan.moe/v3/user/kuro/profile";
  var data;
  Future<MalAccount> futureMalAccount;

  Future<MalAccount> getData() async {
    if (Provider.of<MalAccountProvider>(context, listen: false).account ==
        null) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = MalAccount.fromJson(json.decode(response.body));
        Provider.of<MalAccountProvider>(context, listen: false)
            .addAccount(data);
        return data;
      } else {
        this.getData();
      }
    } else {
      return Provider.of<MalAccountProvider>(context, listen: false).account;
    }
  }

  void initState() {
    super.initState();
    futureMalAccount = this.getData();
  }

  Future<void> _handleSignOut() async {
    await Provider.of<Auth>(context, listen: false).googleSignIn.disconnect();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final _account = Provider.of<Auth>(context).account;
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://wallpaperaccess.com/full/44281.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(_account.photoUrl),
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.blue[200],
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        _account.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _account.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white70,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 5),
              Center(
                child: RaisedButton(
                  onPressed: _handleSignOut,
                  color: Colors.red[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        Divider(
          height: 10,
          color: Colors.black45,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
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
                    "MyAnimeList Account",
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Colors.lightBlue[50],
                ),
                child: FutureBuilder(
                  future: futureMalAccount,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MalAccountInfo(
                        snapshot: snapshot,
                      );
                    } else if (snapshot.hasError) {
                      throw Exception(snapshot.error);
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(height: 20),
      ],
    );
  }
}
