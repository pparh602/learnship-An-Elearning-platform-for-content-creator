import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;
  final int followers;
  final int following;
  final String bio;

  const User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageUrl,
    @required this.followers,
    @required this.following,
    this.bio,
  });
  //User is static const but it gives error that's why changed by static final
  static const empty = User(
    id: '',
    username: '',
    email: '',
    profileImageUrl: '',
    followers: 0,
    following: 0,
    bio: '',
  );

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data();
    return User(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      followers: (data['followers'] ?? 0).toInt(),
      following: (data['following'] ?? 0).toInt(),
      bio: data['bio'] ?? '',
    );
  }
  User copyWith({
    String id,
    String username,
    String email,
    String profileImageUrl,
    int followers,
    int following,
    String bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object> get props =>
      [id, username, email, profileImageUrl, followers, following, bio];
}
