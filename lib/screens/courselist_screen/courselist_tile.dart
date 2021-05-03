import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnship/screens/play_screen/play_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_parser/youtube_parser.dart';

class CourseListTile extends StatelessWidget {
  final String url;

  const CourseListTile({
    Key key,
    @required this.url,
  }) : super(key: key);

  Future<String> getTitle() async {
    final yt = YoutubeExplode();
    //final tutorialId = getIdFromUrl(url);
    // print(' Tutorials ID : $tutorialId');
    // print(' Tutorials ID Type : ${tutorialId.runtimeType}');
    final video = await yt.videos.get(url);
    return video.title;
  }

  @override
  Widget build(BuildContext context) {
    // print('INside the Video Tile WIdget: $url');
    return Container(
      child: FutureBuilder(
          future: getTitle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String title = snapshot.data ?? 'Loading';

              return ListTile(
                title: Text(
                  '$title',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.video_label,
                  color: Colors.red,
                  size: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) {
                      return PlayScreen(
                        videoTitle: snapshot.data,
                        currentvideoID: getIdFromUrl(url),
                      );
                    }),
                  );
                },
              );
            } else {
              return Center(
                child: Text(snapshot.error ?? 'Loading...'),
              );
            }
          }),
    );
  }
}
