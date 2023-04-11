import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf/constants/constants.dart';
import 'dart:convert';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  List<String> searchcase;
  List<String> recent;

  UserChat(
      {required this.id,
      required this.photoUrl,
      required this.nickname,
      required this.aboutMe,
      required this.searchcase,
      required this.recent});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.caseSearch: json.encode(searchcase),
      FirestoreConstants.recentChat: json.encode(recent),
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    List<String> searchcase = [];
    List<String> recent = [];
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      searchcase = doc.get(FirestoreConstants.caseSearch);
    } catch (e) {}
    try {
      recent = doc.get(FirestoreConstants.recentChat);
    } catch (e) {}
    return UserChat(
        id: doc.id,
        photoUrl: photoUrl,
        nickname: nickname,
        aboutMe: aboutMe,
        searchcase: searchcase,
        recent: recent);
  }
}
