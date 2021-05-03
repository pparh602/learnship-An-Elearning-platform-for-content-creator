import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'courselist_tile.dart';

class CourseListScreen extends StatefulWidget {
  static String routeName = 'courseListPage';
  final DocumentSnapshot courses;

  const CourseListScreen({Key key, @required this.courses}) : super(key: key);

  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  List<String> videoUrls = [];

  @override
  void initState() {
    final List courseItems = widget.courses.get('courseItems');
    for (var course in courseItems) {
      videoUrls.add(course.toString());
    }
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
                  child: CourseListTile(
                    url: videoUrls[index],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

/*
ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot courses = widget.snapshot.data.docs[index];
        return !widget.snapshot.hasData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListTile(
                title: courses['courseItems'],
              );
  },
);

 Future getTitles() async {
    final List<String> tutorialsTitles = [];

    final courseItems = widget.courses.get('courseItems');
    final videosUrls = courseItems.map((e) => e.toString()).toList();
    final tutorialId =
        videosUrls.map((e) => getIdFromUrl(e.toString())).toList();
    final tutorialTitle = tutorialId
        .map((e) => yt.videos.get(e).then((value) {
              print('tutorialModel to String: ${value.title}');
              videoTitles.add(value.title);
              return value.title;
            }))
        .toList();

    print('tutorialsTitles to : $videoTitles');
    return videoTitles;
    print('Inside courseItems: $courseItems');
    print('Inside courseItems: ${courseItems.runtimeType}'); // List<dynamic>
    print('Inside videosUrls: $videosUrls');
    print(
        'Inside videosUrls Runtime: ${videosUrls.runtimeType}'); // List<dynamic>

    print('Inside the  tutorialId: $tutorialId');
    print(
        'Inside the  tutorialId Runtime Type : ${tutorialId.runtimeType}'); //List<dynamic>

    print('Inside tutorialTitle ${tutorialTitle.runtimeType}');
    print('Inside tutorialTitle:  $tutorialTitle');
    for (var u in videoUrls) {
      videoUrls.add(u.toString());
      print('Inside for loop: $u ');
      print('Inside for loop: ${u.runtimeType}');
    }
    print(videoUrls.runtimeType);
    videoUrls = videoUrls.toList(growable: true);
    videoIds = videoUrls.map((e) => getIdFromUrl(e));
    print(videoUrls);
    print(
        'Inside the getTitles videoTitles RuntimeType: ${videoTitles.runtimeType}');
  }
  
  */
