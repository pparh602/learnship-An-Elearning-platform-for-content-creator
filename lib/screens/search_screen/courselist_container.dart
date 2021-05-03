import 'package:flutter/material.dart';

class CourseListContainer extends StatelessWidget {
  final String url;

  const CourseListContainer({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '$url',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.video_label,
        color: Colors.red,
        size: 30,
      ),
    );
  }
}
