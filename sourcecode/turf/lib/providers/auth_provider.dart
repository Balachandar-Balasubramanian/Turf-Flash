import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;
  String LoginError = "";

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  dynamic getPref(String key) {
    return prefs.getStringList(key);
  }

  String? getUserFirebaseNickName() {
    return prefs.getString(FirestoreConstants.nickname);
  }

  Future<bool> isLoggedIn() async {
    if (prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  List<String> _setSearchPara(String? name) {
    name = name ?? '';
    name = name.replaceAll(' ', '').toLowerCase();
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  Future<bool> handleSignup({
    required String email,
    required String password,
    required String nickname,
    required String photoURL,
  }) async {
    _status = Status.authenticating;
    notifyListeners();
    User? firebaseUser;
    try {
      try {
        firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
      } on FirebaseAuthException catch (e) {
        LoginError = e.code;
        print(LoginError);
        _status = Status.authenticateCanceled;
        notifyListeners();
        return false;
        // TODO
      }
      print("success");
      // Writing data to server because here is a new user
      List<String> recent = [];
      firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(firebaseUser!.uid)
          .set({
        FirestoreConstants.aboutMe: "",
        FirestoreConstants.nickname: nickname,
        FirestoreConstants.photoUrl: photoURL,
        FirestoreConstants.aboutMe: "Hey there! I'm using Turf flash",
        FirestoreConstants.id: firebaseUser.uid,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        FirestoreConstants.chattingWith: null,
        FirestoreConstants.recentChat: recent,
        FirestoreConstants.caseSearch: _setSearchPara(nickname),
      });

      // Write data to local storage
      User? currentUser = firebaseUser;
      await prefs.setString(FirestoreConstants.id, currentUser.uid);
      await prefs.setString(FirestoreConstants.nickname, nickname);
      await prefs.setString(
          FirestoreConstants.aboutMe, "Hey there! I'm using Turf flash");
      await prefs.setString(FirestoreConstants.photoUrl, photoURL);
      await prefs.setStringList(FirestoreConstants.recentChat, recent);
      await prefs.setStringList(FirestoreConstants.caseSearch,
          _setSearchPara(firebaseUser.displayName));
      _status = Status.authenticated;
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();
      print(e.message);
      LoginError = e.message!;
      return false;
    }
  }

  Future<bool> handleSignIn(
      {required String email, required String password}) async {
    _status = Status.authenticating;
    notifyListeners();
    try {
      User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Writing data to server because here is a new user
          List<String> recent = [];
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstants.nickname: firebaseUser.displayName,
            FirestoreConstants.photoUrl: firebaseUser.photoURL,
            FirestoreConstants.id: firebaseUser.uid,
            FirestoreConstants.aboutMe: "Hey there! I'm using Turf flash",
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null,
            FirestoreConstants.recentChat: recent,
            FirestoreConstants.caseSearch:
                _setSearchPara(firebaseUser.displayName),
          });

          // Write data to local storage
          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.nickname, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.aboutMe, "Hey there! I'm using Turf flash");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setStringList(FirestoreConstants.recentChat, recent);
          await prefs.setStringList(FirestoreConstants.caseSearch,
              _setSearchPara(firebaseUser.displayName));
        } else {
          // Already sign up, just get data from firestore
          DocumentSnapshot documentSnapshot = documents[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
          // Write data to local
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.aboutMe, "Hey there! I'm using Turf flash");
          await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
          await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setStringList(
              FirestoreConstants.recentChat, userChat.recent);
          await prefs.setStringList(FirestoreConstants.caseSearch,
              _setSearchPara(firebaseUser.displayName));
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } on FirebaseException catch (e) {
      _status = Status.authenticateError;
      notifyListeners();
      LoginError = e.code;
      return false;
    }
  }

  Future<bool> handleGSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        final List<String> recent = [];
        if (documents.length == 0) {
          // Writing data to server because here is a new user
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstants.nickname: firebaseUser.displayName,
            FirestoreConstants.photoUrl: firebaseUser.photoURL,
            FirestoreConstants.id: firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null,
            FirestoreConstants.recentChat: recent,
            FirestoreConstants.aboutMe: "Hey there! I'm using Turf flash",
            FirestoreConstants.caseSearch:
                _setSearchPara(firebaseUser.displayName),
          });

          // Write data to local storage
          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.aboutMe, "Hey there! I'm using Turf flash");
          await prefs.setString(
              FirestoreConstants.nickname, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setStringList(FirestoreConstants.recentChat, recent);
          await prefs.setStringList(FirestoreConstants.caseSearch,
              _setSearchPara(firebaseUser.displayName));
        } else {
          // Already sign up, just get data from firestore
          DocumentSnapshot documentSnapshot = documents[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
          // Write data to local
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.aboutMe, "Hey there! I'm using Turf flash");
          await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
          await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setStringList(FirestoreConstants.recentChat, recent);
          await prefs.setStringList(FirestoreConstants.caseSearch,
              _setSearchPara(firebaseUser.displayName));
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  void handleException() {
    _status = Status.authenticateException;
    notifyListeners();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  Future<void> updateDataFirestore(String path, List<String> recent) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(path)
        .update({FirestoreConstants.recentChat: recent});
    // .update(FirestoreConstants.pathUserCollection);
  }

  Future<List<String>> getRecent(String id) async {
    // DocumentSnapshot docs= firebaseFirestore
    //     .collection(FirestoreConstants.pathUserCollection).
    final QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: id)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    DocumentSnapshot documentSnapshot = documents[0];
    return documentSnapshot.get(FirestoreConstants.recentChat);
  }

  Future<bool> setPref(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }
}
