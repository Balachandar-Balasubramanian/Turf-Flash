import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/models/match.dart';
import 'package:turf/pages/pages.dart';

class MatchPost extends StatelessWidget {
  Matches match;
  MatchPost({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => matchDetailsPage(
                      match: match,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
            height: 180,
            width: 388,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage('assets/images/BGmatch.png'),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/team_icon2.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.teamName,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.locationDot,
                              size: 32, color: Colors.white),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 192,
                                child: Text(
                                  match.turfName.toUpperCase(),
                                  maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.calendarDays,
                              size: 32, color: Colors.white),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                match.date + " " + match.time,
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.white),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
