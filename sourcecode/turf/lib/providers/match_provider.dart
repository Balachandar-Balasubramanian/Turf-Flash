// import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:turf/models/book.dart';
import 'package:turf/models/match.dart';

import '../constants/constants.dart';

class MatchProvider {
  final FirebaseFirestore firebaseFirestore;
  // final FirebaseStorage firebaseStorage;
  MatchProvider({
    required this.firebaseFirestore,
    // required this.firebaseStorage,
  });
  // CollectionReference bookings = firebaseFirestore.collection('bookings');
  Stream<QuerySnapshot> getStreamFireStore(String pathCollection) {
    return firebaseFirestore.collection(pathCollection).snapshots();
  }

  Future<void> uploadBookingFireStore(
      String collectionPath, Matches currentMatch) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc()
        .set(currentMatch.toJson());
  }
}
