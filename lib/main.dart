import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnship/pages/bookmark_page/bookmark_page.dart';
import 'package:learnship/pages/feed_page/feed_page.dart';
import 'package:learnship/pages/home_page/home_page.dart';
import 'package:learnship/pages/home_page/search_page.dart';
import 'package:learnship/pages/quest_room_page/quest_page.dart';
import 'package:learnship/utilities/keys.dart';
import 'package:youtube_api/youtube_api.dart';

import 'fab_bottom_app_bar.dart';
import 'fab_with_icons.dart';
import 'layout.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'BottomAppBar with FAB'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _lastSelected = 0;
  TextEditingController searchController = TextEditingController();

  YoutubeAPI ytApi = YoutubeAPI(API_KEY);
  List<YT_API> ytResult = [];

  callAPI() async {
    ytResult = await ytApi.search(searchController.text);
    ytResult = await ytApi.nextPage();
    ytResult = await ytApi.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //callAPI();
    print('hello');
  }

  final List _children = [
    HomePage(),
    FeedPage(),
    QuestPage(),
    BookmarkPage(),
  ];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_lastSelected],
        bottomNavigationBar: FABBottomAppBar(
          centerItemText: 'A',
          color: Colors.grey,
          selectedColor: Colors.red,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home_rounded),
            FABBottomAppBarItem(iconData: Icons.all_inclusive_rounded),
            FABBottomAppBarItem(iconData: Icons.group_rounded),
            FABBottomAppBarItem(iconData: Icons.bookmarks_rounded),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(
            context), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.local_library_rounded];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                searchQuery: searchController.text,
                ytApi: ytApi,
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
