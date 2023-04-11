import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf/constants/constants.dart';

class Matches {
  final String customerId;
  final String customerName;
  String turfName;
  String date;
  String time;
  String PhoneNumber;
  String teamName;
  Matches(
      {required this.teamName,
      required this.customerId,
      required this.customerName,
      required this.date,
      required this.time,
      required this.PhoneNumber,
      required this.turfName});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.turfName: turfName,
      FirestoreConstants.customerId: customerId,
      FirestoreConstants.customerName: customerName,
      FirestoreConstants.date: date,
      FirestoreConstants.PhoneNumber: PhoneNumber,
      FirestoreConstants.time: time,
      FirestoreConstants.teamName: teamName
    };
  }

  factory Matches.fromDocument(DocumentSnapshot doc) {
    String customerId = "";
    String customerName = "";
    String turfName = "";
    String date = "";
    String time = "";
    String PhoneNumber = "";
    String teamName = "";
    try {
      teamName = doc.get(teamName);
      print(teamName);
    } catch (e) {}
    try {
      customerId = doc.get(FirestoreConstants.customerId);
    } catch (e) {}
    try {
      customerName = doc.get(FirestoreConstants.customerName);
    } catch (e) {}
    try {
      turfName = doc.get(FirestoreConstants.turfName);
    } catch (e) {}
    try {
      date = doc.get(FirestoreConstants.date);
    } catch (e) {}
    try {
      time = doc.get(FirestoreConstants.time);
    } catch (e) {}
    try {
      PhoneNumber = doc.get(FirestoreConstants.PhoneNumber);
    } catch (e) {}
    return Matches(
      teamName: teamName,
      customerId: customerId,
      turfName: turfName,
      customerName: customerName,
      date: date,
      time: time,
      PhoneNumber: PhoneNumber,
    );
  }
}
