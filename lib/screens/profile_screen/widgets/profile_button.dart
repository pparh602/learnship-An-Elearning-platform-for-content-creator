import 'package:flutter/material.dart';
import 'package:learnship/screens/edit_profile_screen/edit_profile_screen.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key key,
    @required this.isCurrentUser,
    @required this.isFollowing,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? FlatButton(
            onPressed: () => Navigator.pushNamed(
              context,
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context: context),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          )
        : FlatButton(
            onPressed: () {},
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            textColor: isFollowing ? Colors.black : Colors.white,
            color:
                isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,
          );
  }
}
