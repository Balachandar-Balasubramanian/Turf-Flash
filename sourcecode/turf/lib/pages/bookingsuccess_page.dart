import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turf/pages/home_page.dart';

class BookingConfirmationPage extends StatefulWidget {
  @override
  _BookingConfirmationPageState createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/54141-google-pay-success.json",
                repeat: false),
            Text(
              "Your Booking has been Sucessfull",
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                print("Sucess");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff6f61e8)),
                height: 44,
                width: 150,
                child: Center(
                  child: Text(
                    "Return Home",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
