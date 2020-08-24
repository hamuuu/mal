import 'package:flutter/material.dart';
import 'package:mal/pages/account.dart';
import 'package:mal/pages/forum.dart';
import 'package:mal/pages/home.dart';
import 'package:mal/pages/news.dart';
import 'package:mal/providers/auth.dart';
import 'package:mal/providers/destination.dart';
import 'package:provider/provider.dart';

/// This Widget is the main application widget.
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        toolbarOpacity: 0.2,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 10)
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
