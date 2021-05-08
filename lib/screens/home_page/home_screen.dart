import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learnship/logic/bloc/blocs.dart';
import 'package:learnship/screens/courselist_screen/courselist_screen.dart';
import 'package:learnship/screens/home_page/search_screen.dart';
import 'package:learnship/screens/widgets/error_dialog.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String key = "AIzaSyB5Spz0ROPoQ0J1HsorKOldqIsEeshMaSk";
  TextEditingController searchController = TextEditingController();
  var yt = YoutubeExplode();
  YoutubeAPI ytApi = YoutubeAPI(key);
  List<YT_API> ytResult = [];
  List<Video> videoModels = [];
  List<String> videoUrls = [];
  List<String> videoIDs = [];
  List<String> videoTitles = [];

  callAPI() async {
    ytResult = await ytApi.search(searchController.text);
    // ytResult = await ytApi.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //callAPI();
    print('Inside Home Screen Init');
  }

  List<String> imageList = [
    'assets/course_image/Data Structures.jpg',
    'assets/course_image/database_1.jpg',
    'assets/course_image/Database.jpg',
    'assets/course_image/flutter.jpg',
    'assets/course_image/ML.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        body: Column(
          children: [
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                print(state.user.username.toString());
                if (state.status == ProfileStatus.error) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(content: state.failure.message),
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      state.user.username.toString(),
                      style: TextStyle(
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(
                      flex: 9,
                    ),
                    CircleAvatar(
                      radius: size.height * 0.04,
                      backgroundImage: NetworkImage(state.user.profileImageUrl),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                );
              },
            ),
            //Search Bar
            Container(
              padding: EdgeInsets.all(10),
              //  padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.black, fontSize: 22.0),
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 14.0),
                      prefixIcon: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(
                                ytApi: ytApi,
                                searchQuery: searchController.text,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: "Search"),
                ),
              ),
            ),

            _space,
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("courses")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot courses =
                                    snapshot.data.docs[index];

                                return Column(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseListScreen(
                                                courses: courses,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                              courses['imgUrl'],
                                              fit: BoxFit.cover,
                                              height: size.height * 0.3),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text(
                                            courses['courseTitle'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return new StaggeredTile.count(
                                    1, index.isEven ? 1.2 : 1.8);
                              },
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}

/*
  //final _videoUrls = courses.get('courseItems');

                              // videoUrls = _videoUrls
                              //     .map<String>((e) => e.toString())
                              //     .toList();

                              // videoIDs = _videoUrls
                              //     .map<String>((e) => getIdFromUrl(e))
                              //     .toList();
*/
