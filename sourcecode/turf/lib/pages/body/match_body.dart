import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/models/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/models/Turf.dart';
import 'package:turf/providers/providers.dart';

import 'package:turf/widgets/widgets.dart';
import 'package:turf/widgets/widgets.dart';

class MatchBody extends StatefulWidget {
  const MatchBody({super.key});

  @override
  State<MatchBody> createState() => _MatchBodyState();
}

class _MatchBodyState extends State<MatchBody> {
  late MatchProvider matchProvider;
  final ScrollController listScrollController = ScrollController();
  void initState() {
    matchProvider = context.read<MatchProvider>();
  }

  @override
  Widget build(BuildContext context) {
    List<Image> carousel_ads = [
      Image.asset("assets/images/ad1.jpg"),
      Image.asset("assets/images/ad2.jpg"),
      Image.asset("assets/images/ad3.jpg"),
      Image.asset("assets/images/ad4.jpg"),
      Image.asset("assets/images/ad5.jpg"),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: matchProvider
                .getStreamFireStore(FirestoreConstants.pathMatchesCollection),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data?.docs.length ?? 0) > 0) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data?.docs[index]),
                    itemCount: snapshot.data?.docs.length,
                    controller: listScrollController,
                  );
                } else {
                  return Center(
                    child: Text("No Turf"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.themeColor,
                  ),
                );
              }
            },
          )

          // PostsStream(isMe: false),
          // MatchPost(
          //   photoURL: 'assets/images/team_icon.png',
          //   teamname: "Team Spartans",
          //   location: "EL CLASICO, Selaiyur",
          //   time: "18/02/23, 8 pm - 9 pm",
          // ),
          // MatchPost(
          //   photoURL: 'assets/images/team_icon1.png',
          //   teamname: "Team Vikings",
          //   location: "ULTIMATE SPORTS, Navallur",
          //   time: "19/02/23, 4 pm - 5 pm",
          // ),
          // MatchPost(
          //   photoURL: 'assets/images/team_icon2.png',
          //   teamname: "Team Soccer XI",
          //   location: "TUSSLEZ, Perungulathur",
          //   time: "19/02/23, 7 pm - 8 pm",
          // ),
          // MatchPost(
          //   photoURL: 'assets/images/team_icon.png',
          //   teamname: "Team Football XI",
          //   location: "EL CLASICO, Selaiyur",
          //   time: "18/02/23, 8 pm - 9 pm",
          // ),
          // MatchPost(
          //   photoURL: 'assets/images/team_icon2.png',
          //   teamname: "Team All Star XI",
          //   location: "EL CLASICO, Selaiyur",
          //   time: "18/02/23, 8 pm - 9 pm",
          // ),
        ],
      ),
    );
  }
}

Widget buildItem(BuildContext context, DocumentSnapshot? document) {
  // List<String> recent = [];

  if (document != null) {
    // print(document.get("ImagesURL"));
    // recent = homeProvider.getPref(FirestoreConstants.recentChat);
    // print((recent.length));
// userChat.id == currentUserId || !recent.contains(userChat)
    Matches match = Matches.fromDocument(document);
    match.teamName = document.get("teamName");
    match.date = document.get("date");
    print(match.date);
    // flagchat = false;
    return MatchPost(match: match);
  } else {
    return SizedBox.shrink();
  }
}
