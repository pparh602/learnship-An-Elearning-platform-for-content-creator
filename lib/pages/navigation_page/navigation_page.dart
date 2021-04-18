import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnship/pages/bookmark_page/bookmark_page.dart';
import 'package:learnship/pages/feed_page/feed_page.dart';
import 'package:learnship/pages/home_page/home_page.dart';
import 'package:learnship/pages/quest_room_page/quest_page.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class NavigationPage extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final ValueChanged<int> onTabSelected;

  const NavigationPage({Key key, this.items, this.onTabSelected})
      : super(key: key);
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _children = [
    HomePage(),
    FeedPage(),
    QuestPage(),
    BookmarkPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add, size: 30),
        elevation: 2.0,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.blueGrey,
              elevation: 18.0,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/home.svg',
                    height: 30.0,
                    color: Color(0xFF959595),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/home.svg',
                    height: 30,
                    color: Color(0xFFffe36b),
                  ),
                  label: 'Sleep Timer',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/activity.svg',
                    height: 30,
                    color: Color(0xFF959595),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/activity.svg',
                    height: 30,
                    color: Color(0xFFffe36b),
                  ),
                  label: 'Play Lit',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/help.svg',
                    height: 30.0,
                    color: Color(0xFF959595),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/help.svg',
                    height: 30.0,
                    color: Color(0xFFffe36b),
                  ),
                  label: 'Timer',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/bookmark.svg',
                    height: 30.0,
                    color: Color(0xFF959595),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/bookmark.svg',
                    height: 30.0,
                    color: Color(0xFFffe36b),
                  ),
                  label: 'Timer',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),
      body: SafeArea(
        child: _children[_currentIndex],
      ),
    );
  }
}
