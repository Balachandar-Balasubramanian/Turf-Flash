import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/constants/color_constants.dart';
import 'package:turf/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'pages.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // just delay for showing this slash page clearer because it too fast
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Container(
                  height: 400,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Text(
                "Turf Flash",
                style: GoogleFonts.bebasNeue(
                    fontWeight: FontWeight.w500, fontSize: 60),
              )
            ],
          ),
        ),
      ),
    );
  }
}
