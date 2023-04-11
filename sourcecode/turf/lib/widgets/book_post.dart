import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../pages/pages.dart';

class BookPost extends StatelessWidget {
  Turf turf;
  BookPost({
    super.key,
    required this.turf,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(turf.name);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BookPage(
        //               turf: turf,
        //             )));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => turfDetailPage(
                      turf: turf,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 230,
          // color: Colors.green,
          child: Stack(alignment: Alignment.bottomRight, children: [
            Container(
              height: 200,
              width: 388,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 8.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/BGgrass.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 80,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              turf.name.toUpperCase(),
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  fontSize: 26, color: Colors.white),
                            ),
                            Text(
                              turf.location,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.locationDot),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    turf.distance + " Kms",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber[400],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    turf.rating,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.indianRupeeSign),
                              SizedBox(width: 4),
                              Text(
                                turf.price + '/hr',
                                style: GoogleFonts.poppins(
                                    fontSize: 24, color: Color(0xff707070)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              height: 120,
              width: 120,
              left: 20,
              // right: 0,
              top: 0,
              // bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  turf.logoURL,
                  fit: BoxFit.cover,
                ),
              ),

              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(18),
              //     color: Colors.grey,
              //   ),
              //   child: Image.network(
              //     turf.logoURL,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ]),
        ),
      ),
    );
  }
}
