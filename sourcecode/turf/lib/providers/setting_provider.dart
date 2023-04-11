import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';
import '../models/user_chat.dart';

class SettingProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  SettingProvider({
    required this.prefs,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });
  String? getPref(String key) {
    return prefs.getString(key);
  }

  dynamic getPrefdynamic(String key) {
    return prefs.getStringList(key);
  }

  Future<bool> setPref(String key, String value) async {
    return await prefs.setString(key, value);
  }

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref('users').child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(
      String collectionPath, String path, UserChat updateInfo) {
    return firebaseFirestore.collection(collectionPath).doc(path).update({
      FirestoreConstants.id: updateInfo.id,
      FirestoreConstants.photoUrl: updateInfo.photoUrl,
      FirestoreConstants.aboutMe: updateInfo.aboutMe,
      FirestoreConstants.nickname: updateInfo.nickname,
      FirestoreConstants.caseSearch: updateInfo.searchcase,
    });
  }

  // id: id,
  // photoUrl: photoUrl,
  // nickname: nickname,
  // aboutMe: aboutMe,
  // searchcase: _setSearchPara(nickname),
  Future<void> updateSearchCase(
      String collectionPath, String path, List<String> caseSearch) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .set({FirestoreConstants.caseSearch: caseSearch});
  }
}
