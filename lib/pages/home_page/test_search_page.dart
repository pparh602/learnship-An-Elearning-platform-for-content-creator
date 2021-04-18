import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  SearchPage({Key key, this.searchQuery}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
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
            ],
          ),
        ),
      ),
    );
  }
}
