import 'package:flutter/material.dart';
import 'package:mal/pages/account.dart';
import 'package:mal/pages/forum.dart';
import 'package:mal/pages/home.dart';
import 'package:mal/pages/news.dart';
import 'package:mal/providers/auth.dart';
import 'package:mal/providers/destination.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DestinationRouter();
  }
}

class DestinationRouter extends StatefulWidget {
  DestinationRouter({Key key}) : super(key: key);

  @override
  _DestinationRouterState createState() => _DestinationRouterState();
}

class _DestinationRouterState extends State<DestinationRouter> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    News(),
    Forum(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _name = Provider.of<Auth>(context).account.displayName;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'YOU ARE IN',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$_name',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
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
              child: Container(
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
            ),
            expandedHeight: 70,
          ),
          SliverToBoxAdapter(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        selectedIconTheme: IconThemeData(color: Colors.blue[200]),
        selectedItemColor: Colors.blue[200],
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: allDestinations.map(
          (Destination d) {
            return BottomNavigationBarItem(
              icon: Icon(
                d.icon,
              ),
              backgroundColor: d.color,
              title: Text(
                d.title,
              ),
            );
          },
        ).toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
