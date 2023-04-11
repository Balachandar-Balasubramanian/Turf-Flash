// import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:turf/models/book.dart';

import '../constants/constants.dart';

class BookProvider {
  final FirebaseFirestore firebaseFirestore;
  // final FirebaseStorage firebaseStorage;
  BookProvider({
    required this.firebaseFirestore,
    // required this.firebaseStorage,
  });
  // CollectionReference bookings = firebaseFirestore.collection('bookings');
  Stream<QuerySnapshot> getBooksStreamFireStore(
      String pathCollection, String date, String turfId) {
    print("DATE:" + date);
    return firebaseFirestore
        .collection(pathCollection)
        .where(FirestoreConstants.turfId, isEqualTo: turfId)
        .where(FirestoreConstants.date, isEqualTo: date)
        .snapshots();
  }

  Future<void> uploadBookingFireStore(
      String collectionPath, BookingTurf currentBook) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc()
        .set(currentBook.toJson());
  }
}
