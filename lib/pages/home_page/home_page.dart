import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learnship/pages/home_page/search_page.dart';
import 'package:youtube_api/youtube_api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String key = "AIzaSyB5Spz0ROPoQ0J1HsorKOldqIsEeshMaSk";
  TextEditingController searchController = TextEditingController();

  YoutubeAPI ytApi = YoutubeAPI(key);
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
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(
                flex: 1,
              ),
              Text(
                'Hi, Parth!',
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
                backgroundImage: AssetImage('assets/course_image/Parth.jpg'),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ), // Header
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    prefixIcon: InkWell(
                      onTap: () {
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
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Search"),
              ),
            ),
          ), //Search Bar
          _space,
          Container(
            //color: Colors.red,
            height: size.height * 0.30,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Enrolled Courses:',
                  style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                    "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200214165928/Web-Development-Course-Thumbnail.jpg",
                                    fit: BoxFit.fitWidth,
                                    height: size.height * 0.3),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.8,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(12),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                              "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200214165928/Web-Development-Course-Thumbnail.jpg",
                              fit: BoxFit.cover,
                              height: size.height * 0.3),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              'Course Title',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}

/**
 *  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(
                  flex: 1,
                ),
                Text(
                  'Hey Parth',
                  style: TextStyle(
                    fontSize: size.height * 0.04,
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/course_image/Parth.jpg'),
                  radius: 35,
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),

             List<String> imageList = [
    'https://img-a.udemycdn.com/course/480x270/1708340_7108_4.jpg?eE-WG-Xjjb_pywmuWW_iZ9CDGcyaCglaG6Cl_UNv7cVgj69NatYGPU5iL-NIzHxTFqDKpovQfmmik-2WKCVXeINeVAB1nzKsV24nw-faXDtswNCKco47jrz49UVcpLun',
    'https://img-b.udemycdn.com/course/480x270/950390_270f_3.jpg?secure=RqjTSpYF2yU7LWBMbixD0A%3D%3D%2C1603771306',
    'https://img-b.udemycdn.com/course/480x270/1419182_b2cf.jpg?secure=IsqtinHqrdE91IlgzP1tYQ%3D%3D%2C1603785363',
    'https://img-b.udemycdn.com/course/480x270/548278_b005_9.jpg?secure=CPBerRSLgAHOage9mEXfew%3D%3D%2C1603766142',
    'https://img-a.udemycdn.com/course/480x270/1362070_b9a1_2.jpg?VwTLiahNMJdSw3_g9xwhfyuN1YCX7m_nwzuBN8TPySmGl1JET0VkFone6URsioGSSUVW2DjNNBrn1Uu5wP9WsI-b4nOOUW7xqSXkk5ZKlqdMGS_YF3lqJaiO4zOYG8_U',
    'https://img-a.udemycdn.com/course/480x270/438522_500f_6.jpg?El2rnSTQGJ1_QQKjFO5SOfSNAB5H94Jgj60adkbxVJeM7IbBgclDRXcbWpnKyVKo54zdxOQDpSEo-tir-l-bI16ymUZKwa1P5XpLZbayffXo386lUEFU-1Xs-ssqfGQ',
    'https://img-a.udemycdn.com/course/480x270/857010_8239_2.jpg?j9sQ5SMFWmVz9c1ajiajXfptwcF5xsMAOqTXAgpLKB2ffL5t2eA426Z5abuOU8c-phvcz9N8wmEmqUTr6CuK6HiseMqOB8XeM7YVII3ZVLSX-ckn1JLUidzoIgdyEcI',
    'https://img-a.udemycdn.com/course/480x270/1362070_b9a1_2.jpg?VwTLiahNMJdSw3_g9xwhfyuN1YCX7m_nwzuBN8TPySmGl1JET0VkFone6URsioGSSUVW2DjNNBrn1Uu5wP9WsI-b4nOOUW7xqSXkk5ZKlqdMGS_YF3lqJaiO4zOYG8_U',
    'https://img-a.udemycdn.com/course/480x270/625204_436a_2.jpg?muhE0cDCGk7_7AaXbXn2PKTt1QXzpy2vbC7GoA42rVR3kjKRFvx4jDbsjpYcM4kxXUW03gTtJiB_9d0gI9RuHo7nh-NN3uzU2Nm9pOIpkCFfgd9IXXVYsw8pln8pHec'
  ];

     List<String> imageList = [
    'assets/course_image/Data Structures.jpg',
    'assets/course_image/database_1.jpg',
    'assets/course_image/Database.jpg',
    'assets/course_image/flutter.jpg',
    'assets/course_image/Machine Learning.jpg',
    'assets/course_image/ML.jpg'
  ];
 
            
 */
