import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/models/match.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import 'pages.dart';

class matchDetailsPage extends StatefulWidget {
  Matches match;
  matchDetailsPage({super.key, required this.match});

  @override
  State<matchDetailsPage> createState() => _matchDetailsPageState();
}

class _matchDetailsPageState extends State<matchDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        'assets/images/MESSIBG.png'),
                  ),
                  Container(
                    height: 250,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: double.infinity,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        )),
                  ),
                  //
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.shieldAlt,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Team Name: ' + widget.match.teamName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.user,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Captain Name: ' + widget.match.customerName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Location: ' + widget.match.turfName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.calendarAlt,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Date: ' + widget.match.date,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Time:' + widget.match.time,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.phoneAlt,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Phone Number: ' + widget.match.PhoneNumber,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      Uri url =
                          Uri(scheme: 'tel', path: widget.match.PhoneNumber);
                      launchUrl(url);
                    },
                    child: Container(
                      width: 132,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      height: 44,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Call",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.phone,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatHomePage()),
                      );
                    },
                    child: Container(
                      width: 132,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      height: 44,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Chat",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.quickreply,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text("Note: you can also chat with " +
                  widget.match.customerName +
                  " from chat menu"),
            ],
          ),
        ),
      ),
    );
  }
}

// CarouselSlider.builder(
//               itemCount: items.length,
//               options: CarouselOptions(
//                 autoPlay: true,
//                 aspectRatio: 2.0,
//                 // enlargeCenterPage: true,
//               ),
//               itemBuilder: (context, index, realIdx) {
//                 return Container(
//                   height: 400,
//                   width: double.infinity,
//                   child: Center(child: items[index]),
//                 );
//               },
//             ),
