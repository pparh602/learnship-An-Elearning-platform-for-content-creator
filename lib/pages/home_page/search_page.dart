import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:learnship/pages/play_page/play_page.dart';
import 'package:learnship/pages/search_page/utils.dart';
import 'package:learnship/utilities/keys.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_api/yt_video.dart';

class SearchPage extends StatefulWidget {
  String searchQuery;
  List<YT_API> ytResult = [];
  YoutubeAPI ytApi;

  SearchPage({Key key, this.searchQuery, this.ytApi}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  callAPI() async {
    widget.ytResult = await widget.ytApi.search(widget.searchQuery);
    widget.ytResult = await widget.ytApi.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                style: TextStyle(color: Colors.black, fontSize: 22.0),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    prefixIcon: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                              searchQuery: searchController.text,
                              ytApi: widget.ytApi,
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemCount: widget.ytResult.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: FocusedMenuHolder(
                              blurBackgroundColor: Colors.blueGrey[900],
                              menuOffset: 20,
                              menuItems: [
                                FocusedMenuItem(
                                    title: Text("Play"),
                                    trailingIcon:
                                        Icon(Icons.play_arrow_outlined),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (builder) {
                                          return PlayPage(
                                            videoTitle:
                                                widget.ytResult[index].title,
                                            currentvideoID:
                                                widget.ytResult[index].id,
                                          );
                                        }),
                                      );
                                      Utils.showSnackbar(context, 'Play');
                                    }),
                                FocusedMenuItem(
                                    title: Text("Add to Course"),
                                    trailingIcon: Icon(Icons.add),
                                    onPressed: () {
                                      Utils.showSnackbar(context, 'Selected');
                                    }),
                                FocusedMenuItem(
                                    title: Text("Share"),
                                    trailingIcon: Icon(Icons.share_outlined),
                                    onPressed: () {
                                      Utils.showSnackbar(context, 'Selected');
                                    }),
                              ],
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                    widget.ytResult[index].thumbnail['default']
                                        ['url'],
                                    fit: BoxFit.cover,
                                    height: size.height * 0.3),
                              ),
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
                                  '${widget.ytResult[index].title}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              // Expanded(
                              //   flex: 2,
                              //   child: IconButton(
                              //       icon: Icon(Icons.more_horiz),
                              //       onPressed: () {}),
                              // ),
                            ],
                          ),
                        ],
                      );
                    },
                    staggeredTileBuilder: (index) {
                      return new StaggeredTile.count(
                          1, index.isEven ? 1.2 : 1.8);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
