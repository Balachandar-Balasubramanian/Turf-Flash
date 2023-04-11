import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf/constants/constants.dart';
// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable(explicitToJson: true)
class BookingTurf {
  final String customerId;
  final String customerName;
  final String turfId;
  final String date;
  final List<String> slots;
  final int price;
  final String turfName;

  BookingTurf(
      {required this.customerId,
      required this.turfId,
      required this.customerName,
      required this.date,
      required this.slots,
      required this.price,
      required this.turfName});

  factory BookingTurf.fromJson(Map<String, dynamic> json) {
    return BookingTurf(
      turfId: json[FirestoreConstants.turfId],
      customerId: json[FirestoreConstants.customerId],
      customerName: json[FirestoreConstants.customerName],
      date: json[FirestoreConstants.date],
      price: json[FirestoreConstants.price],
      slots: json[FirestoreConstants.slots],
      turfName: json[FirestoreConstants.turfName],
    );
  }
  Map<String, String> toJson() {
    return {
      FirestoreConstants.turfId: turfId,
      FirestoreConstants.customerId: customerId,
      FirestoreConstants.customerName: customerName,
      FirestoreConstants.date: date,
      FirestoreConstants.price: price.toString(),
      FirestoreConstants.slots: json.encode(slots),
    };
  }

  factory BookingTurf.fromDocument(DocumentSnapshot doc) {
    String customerId = "";
    String customerName = "";
    String turfId = "";
    String date = "";
    List<String> slots = [];
    int price = 0;
    String turfName = "";
    try {
      customerId = doc.get(FirestoreConstants.customerId);
    } catch (e) {}
    try {
      customerName = doc.get(FirestoreConstants.customerName);
    } catch (e) {}
    try {
      turfId = doc.get(FirestoreConstants.turfId);
    } catch (e) {}
    try {
      date = doc.get(FirestoreConstants.date);
    } catch (e) {}
    try {
      slots = doc.get(FirestoreConstants.slots);
    } catch (e) {}
    try {
      price = doc.get(FirestoreConstants.price);
    } catch (e) {}
    return BookingTurf(
        customerId: customerId,
        turfId: turfId,
        customerName: customerName,
        date: date,
        slots: slots,
        price: price,
        turfName: turfName);
  }
}
