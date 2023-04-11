import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf/constants/firestore_constants.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;
  HomeProvider({
    required this.firebaseFirestore,
    required this.prefs,
  });

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      print(textSearch);
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.caseSearch, arrayContains: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }

  dynamic getPref(String key) {
    return prefs.getStringList(key);
  }
}
