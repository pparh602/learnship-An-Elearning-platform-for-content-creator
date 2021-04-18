import 'package:flutter/material.dart';

class QuestPage extends StatefulWidget {
  QuestPage({Key key}) : super(key: key);

  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: Text(
          'Quest Rooms',
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFF8F8F8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: QuestRoomWidget(
                courseTitle: 'Machine Learning',
                imageSouce: 'assets/course_image/ML.jpg',
                courseDesc: 'ML - The Complete Reference',
                size: size,
              ),
            ),
            Center(
              child: QuestRoomWidget(
                courseTitle: 'RNAsequencing',
                imageSouce: 'assets/course_image/rnaSequance.jpg',
                courseDesc: 'RNA Sequencing',
                size: size,
              ),
            ),
            Center(
              child: QuestRoomWidget(
                courseTitle: 'statistics',
                imageSouce: 'assets/course_image/Statistics.jpg',
                courseDesc: 'Statistical from zero to hero.',
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestRoomWidget extends StatelessWidget {
  final String imageSouce;
  final String courseTitle;
  final String courseDesc;

  QuestRoomWidget({
    Key key,
    @required this.imageSouce,
    @required this.courseTitle,
    @required this.courseDesc,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: size.height * 0.23,
      width: size.width * 0.9,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  '$imageSouce',
                  fit: BoxFit.fill,
                  height: 67,
                  width: 70,
                ),
                SizedBox(width: size.width * 0.05),
                Text(
                  '$courseTitle',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xFFA29CA9), fontSize: 25),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            bottom: 0,
            child: Center(
              child: Text(
                '$courseDesc',
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFA29CA9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            height: 25,
            child: ElevatedButton(
              child: Text('VIEW ROOM'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF40D7CB),
              ),
            ),
          )
        ],
      ),
    );
  }
}
