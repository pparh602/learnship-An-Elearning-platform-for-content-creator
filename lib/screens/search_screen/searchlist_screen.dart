import 'package:flutter/material.dart';
import 'package:learnship/screens/search_screen/courselist_container.dart';

class SearchListScreen extends StatefulWidget {
  static String routeName = 'courseListPage';
  final List<String> videoUrls;
  final List<String> videoTitles;
  final List<String> videoThumbnails;

  const SearchListScreen({
    Key key,
    @required this.videoUrls,
    @required this.videoTitles,
    @required this.videoThumbnails,
  }) : super(key: key);

  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  List<String> videoUrls = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: videoUrls.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CourseListContainer(url: videoUrls[index]),
                ),
              );
            }),
      ),
    );
  }
}
