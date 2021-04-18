import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TabController controller;
  int cupertinoTabBarIValue = 0;
  int cupertinoTabBarIValueGetter() => cupertinoTabBarIValue;
  int cupertinoTabBarIIValue = 1;
  int cupertinoTabBarIIValueGetter() => cupertinoTabBarIIValue;
  int cupertinoTabBarIIIValue = 3;
  int cupertinoTabBarIIIValueGetter() => cupertinoTabBarIIIValue;
  int cupertinoTabBarIVValue = 0;
  int cupertinoTabBarIVValueGetter() => cupertinoTabBarIVValue;
  int cupertinoTabBarVValue = 0;
  int cupertinoTabBarVValueGetter() => cupertinoTabBarVValue;
  int cupertinoTabBarVIValue = 0;
  int cupertinoTabBarVIValueGetter() => cupertinoTabBarVIValue;
  int cupertinoTabBarVIIValue = 2;
  int cupertinoTabBarVIIValueGetter() => cupertinoTabBarVIIValue;
  int cupertinoTabBarVIIIValue = 2;
  int cupertinoTabBarVIIIValueGetter() => cupertinoTabBarVIIIValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 20.0),
            ),
            Container(
              constraints: const BoxConstraints.expand(height: 20.0),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFd4d7dd),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 13, right: 13),
              child: CupertinoTabBar(
                const Color(0xFFd4d7dd),
                const Color(0xFFf7f7f7),
                [
                  const Text(
                    "Top",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "New",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Hot",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Best",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                cupertinoTabBarIIIValueGetter,
                (int index) {
                  setState(() {
                    cupertinoTabBarIIIValue = index;
                  });
                },
                useShadow: true,
                innerHorizontalPadding: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),

  GFAppBar(
        backgroundColor: GFColors.DARK,
        title: GFSegmentTabs(
          tabController: tabController,
          tabBarColor: GFColors.LIGHT,
          labelColor: GFColors.WHITE,
          unselectedLabelColor: GFColors.DARK,
          indicator: BoxDecoration(
            color: GFColors.DARK,
          ),
          indicatorPadding: EdgeInsets.all(8.0),
          indicatorWeight: 2.0,
          border: Border.all(color: Colors.white, width: 1.0),
          length: 4,
          tabs: <Widget>[
            Text(
              "Tab1",
            ),
            Text(
              "Tab2",
            ),
            Text(
              "Tab3",
            ),
            Text(
              "Tab4",
            ),
          ],
        ),
      ),
 */
