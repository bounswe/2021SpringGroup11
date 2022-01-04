import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/user.dart';

void main() {
  test('User follower count must be correct', () {
    final user = User(follower: 15, following: 20, username: "bounrektorluk", email: "boun@boun.edu.tr");
    expect(user.follower,15);
  });

  test('User followings count must be correct', () {
    final user = User(follower: 15, following: 20, username: "bounrektorluk", email: "boun@boun.edu.tr");
    expect(user.following,20);
  });

  test('Username must be correct', () {
    final user = User(follower: 15, following: 20, username: "bounrektorluk", email: "boun@boun.edu.tr");
    expect(user.username,"bounrektorluk");
  });

  test('User email must be correct', () {
    final user = User(follower: 15, following: 20, username: "bounrektorluk", email: "boun@boun.edu.tr");
    expect(user.email,"boun@boun.edu.tr");
  });

  test('User fromJSON must be correct', () {
    final user = User.fromJson({"username": "aziznesin", "email": "aziznesin@gmail.com", "follower": 100, "following": 45});
    expect(user.username,"aziznesin");
    expect(user.email, "aziznesin@gmail.com");
    expect(user.following, 45);
    expect(user.follower, 100);
  });
}