import 'package:flutter/material.dart';

class BottomPageBar extends StatefulWidget {
  @override
  _BottomPageBarState createState() => _BottomPageBarState();
}

class _BottomPageBarState extends State<BottomPageBar> {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          // the tab bar with two items
          SizedBox(
            height: 50,
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Color(0xFF38F2BF),
                  borderRadius: BorderRadius.circular(15),
                ),
                indicatorColor: Color(0xFF38F2BF),
                automaticIndicatorColorAdjustment: true,
                tabs: [
                  Tab(
                    child: Container(
                      child: Text(
                        'Q&A',
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text(
                        'Notes',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // create widgets for each tab bar here
          Expanded(
            child: TabBarView(
              children: [
                //second tab bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Color(0xFFF8F8F8),
                  ),
                  child: Center(
                    child: Text(
                      'Q&A',
                    ),
                  ),
                ),
                //third tab bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Color(0xFFF8F8F8),
                  ),
                  child: Center(
                    child: Text(
                      'Notes',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
