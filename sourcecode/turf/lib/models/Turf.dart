import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Turf {
  String name;
  String id;
  String location;
  String GmapURL;
  String price;
  String rating;
  String distance;
  List ImagesURL;
  String logoURL;
  Turf(
      {required this.id,
      required this.name,
      required this.location,
      required this.GmapURL,
      required this.price,
      required this.rating,
      required this.distance,
      required this.ImagesURL,
      required this.logoURL});

// ignore: non_constant_identifier_names
  factory Turf.fromDocument(DocumentSnapshot doc) {
    String name = "";
    String id = "";
    String location = "";
    String GmapURL = "";
    String price = "";
    String rating = "";
    String distance = "";
    // ignore: non_constant_identifier_names
    List<String> ImagesURL = [];
    String logoURL = "";
    try {
      name = doc.get("name");
    } catch (e) {}
    try {
      id = doc.get("id");
    } catch (e) {}
    try {
      location = doc.get("location");
    } catch (e) {}
    try {
      GmapURL = doc.get("GmapURL");
    } catch (e) {}
    try {
      price = doc.get("price");
    } catch (e) {}
    try {
      rating = doc.get("rating");
    } catch (e) {}
    try {
      distance = doc.get("distance");
    } catch (e) {}
    try {
      logoURL = doc.get("logoURL");
    } catch (e) {}
    try {
      ImagesURL = doc.get("ImagesURL");
    } catch (e) {}
    // print(doc.get("ImagesURL")); //1
    // print(ImagesURL); //2
    return Turf(
        id: doc.id,
        name: name,
        location: location,
        GmapURL: GmapURL,
        price: price,
        rating: rating,
        distance: distance,
        ImagesURL: ImagesURL,
        logoURL: logoURL);
  }
}
