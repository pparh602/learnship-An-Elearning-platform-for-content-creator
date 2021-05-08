import 'package:flutter/material.dart';
import 'package:learnship/screens/profile_screen/widgets.dart';

class ProfileStats extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;
  final int posts;
  final int followers;
  final int following;

  const ProfileStats({
    Key key,
    @required this.isCurrentUser,
    @required this.isFollowing,
    @required this.posts,
    @required this.followers,
    @required this.following,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Stats(
                count: posts,
                lable: 'Courses',
              ),
              _Stats(
                count: followers,
                lable: 'Followers',
              ),
              _Stats(
                count: following,
                lable: 'Following',
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileButton(
              isCurrentUser: isCurrentUser,
              isFollowing: isFollowing,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final String lable;
  final int count;

  const _Stats({
    Key key,
    @required this.lable,
    @required this.count,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          lable,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
