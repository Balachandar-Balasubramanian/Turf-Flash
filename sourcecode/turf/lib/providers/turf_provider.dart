import 'package:cloud_firestore/cloud_firestore.dart';

class TurfProvider {
  final FirebaseFirestore firebaseFirestore;

  TurfProvider({
    required this.firebaseFirestore,
  });
  Stream<QuerySnapshot> getStreamFireStore(String pathCollection) {
    return firebaseFirestore.collection(pathCollection).snapshots();
  }
}
