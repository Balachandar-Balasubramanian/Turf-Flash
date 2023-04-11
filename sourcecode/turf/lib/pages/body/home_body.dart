import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

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
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: carousel_ads,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
          ),
          // PostsStream(isMe: false),
          // SvgPicture.asset('assests/svg/field_icon.svg', color: Colors.black),
          Container(
            height: 400,
            child: SvgPicture.asset('assets/svg/nomatch.svg',
                semanticsLabel: 'Acme Logo'),
          ),
          Text(
            "No Tournaments Available",
            style: GoogleFonts.poppins(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
