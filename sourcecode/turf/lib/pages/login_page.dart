import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/constants/app_constants.dart';
import 'package:turf/constants/color_constants.dart';
import 'package:turf/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    String email = "";
    String password = "";
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Container(
          width: 327,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // child: Hero(
                  //   tag: 'logo',
                  //   child: Container(
                  //       height: 200,
                  //       child: Image.asset('assets/images/logo.png')),
                  // ),
                  child: SvgPicture.asset('assets/svg/login2.svg',
                      semanticsLabel: 'Acme Logo'),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Text(
                  "Email",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500, height: 4),
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                    print(email);
                  },
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Sample@test.com"),
                ),
                Text(
                  "Password",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500, height: 4),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (value) {
                    password = value;
                    print(password);
                  },
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "******"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    print(("hello"));
                    authProvider
                        .handleSignIn(email: email, password: password)
                        .then((isSuccess) {
                      if (isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                LoginPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      }
                    }).catchError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                      authProvider.handleException();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff5429FF)),
                    height: 44,
                    child: Center(
                      child: Text(
                        "Signin",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print(("hello1"));
                    authProvider.handleGSignIn().then((isSuccess) {
                      if (isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    }).catchError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                      authProvider.handleException();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    height: 44,
                    child: Center(
                      child: Text(
                        "Signin With Google",
                        style: GoogleFonts.inter(
                            color: Color(0xff5429FF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account",
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        print("SIGNUP");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff5429FF),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
