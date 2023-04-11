import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import 'pages.dart';

class turfDetailPage extends StatefulWidget {
  Turf turf;
  turfDetailPage({super.key, required this.turf});

  @override
  State<turfDetailPage> createState() => _turfDetailPageState();
}

class _turfDetailPageState extends State<turfDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<Image> items = [
      Image.network(widget.turf.ImagesURL[0],
          fit: BoxFit.cover, width: double.infinity),
      Image.network(widget.turf.ImagesURL[1],
          fit: BoxFit.cover, width: double.infinity),
      Image.network(widget.turf.ImagesURL[2],
          fit: BoxFit.cover, width: double.infinity)
    ];
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlideshow(
              /// Width of the [ImageSlideshow].
              width: double.infinity,

              /// Height of the [ImageSlideshow].
              height: 200,

              /// The page to show when first creating the [ImageSlideshow].
              initialPage: 0,

              /// The color to paint the indicator.
              indicatorColor: Colors.blue,

              /// The color to paint behind th indicator.
              indicatorBackgroundColor: Colors.grey,

              /// The widgets to display in the [ImageSlideshow].
              /// Add the sample image file into the images folder
              children: items,

              /// Called whenever the page in the center of the viewport changes.
              onPageChanged: (value) {
                print('Page changed: $value');
              },

              /// Auto scroll interval.
              /// Do not auto scroll with null or 0.
              autoPlayInterval: 3000,

              /// Loops back to first slide.
              isLoop: true,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.turf.name.toUpperCase(),
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.turf.location.toUpperCase(),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Container(
                      //     height: 40,
                      //     width: 132,
                      //     decoration: BoxDecoration(
                      //       // color: Colors.green,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       // crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           "CALL",
                      //           style: GoogleFonts.poppins(
                      //               fontSize: 20, fontWeight: FontWeight.w600),
                      //         ),
                      //         FaIcon(FontAwesomeIcons.phone)
                      //       ],
                      //     ),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.green),
                      // ),
                      TextButton(
                        onPressed: () async {
                          Uri url = Uri(scheme: 'tel', path: "12345678");
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
                          print(widget.turf.GmapURL);
                          // MapsLauncher.launchQuery(widget.turf.GmapURL);
                          launchUrl(Uri.parse(widget.turf.GmapURL));
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
                                  "Direction",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Amenities",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.toilet),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Toilets",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.shower),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Showers",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.doorClosed),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Lockers",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.toiletPaper),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Towels",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.personBooth),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Dress room",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.parking),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Parking",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.bottleWater),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    " Water",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.creditCard),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Credit card",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookPage(
                                    turf: widget.turf,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      height: 44,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Book Now",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.heartCircleBolt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
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