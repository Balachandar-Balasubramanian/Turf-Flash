import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/constants/app_constants.dart';
import 'package:turf/constants/color_constants.dart';
import 'package:turf/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'pages.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String email = "";
    String password = "";
    String repass = "";
    String nickname = "";
    String photoUrl =
        "https://firebasestorage.googleapis.com/v0/b/turf-c9fc1.appspot.com/o/users%2FdefaultDp.png?alt=media&token=89ecd832-10a4-4502-bf08-4e9846a4ab27";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(24),
          child: Container(
            width: 327,
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
                  child: Container(
                    height: 300,
                    child: SvgPicture.asset('assets/svg/signup.svg',
                        semanticsLabel: 'Acme Logo'),
                  ),
                ),
                Text(
                  "UserName",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500, height: 4),
                ),
                TextField(
                  onChanged: (value) {
                    nickname = value;
                    // print(email);
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
                      hintText: "David Beckham"),
                ),
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
                Text(
                  "Confirm Password",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500, height: 4),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (value) {
                    repass = value;
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
                      hintText: "Re enter password"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    print(("pressed"));

                    if (nickname != "" && email != "" && password != "") {
                      bool t = await authProvider.handleSignup(
                          email: email,
                          password: password,
                          nickname: nickname,
                          photoURL: photoUrl);

                      if (t == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        nickname = password = repass = email = "";
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text('Alert'),
                            content: Text(authProvider.LoginError),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SignupPage(),
                                  //   ),
                                  // );
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              SignupPage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: const Text('Okay'),
                              )
                            ],
                          ),
                        );
                      }
                    } else {
                      print(nickname);
                      print(email);
                      print(password);
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text('Alert'),
                          content: Text("PLease fill all fields"),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);

                                // Navigator.pushReplacement(
                                //   context,
                                //   PageRouteBuilder(
                                //     pageBuilder:
                                //         (context, animation1, animation2) =>
                                //             SignupPage(),
                                //     transitionDuration: Duration.zero,
                                //     reverseTransitionDuration: Duration.zero,
                                //   ),
                                // );
                              },
                              child: const Text('Okay'),
                            )
                          ],
                        ),
                      );
                    }
                    // authProvider
                    //     .handleSignup(
                    //   email: email,
                    //   password: password,
                    //   nickname: nickname,
                    //   photoURL: photoUrl,
                    // )
                    //     .then((isSuccess) {
                    //   if (isSuccess) {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => HomePage(),
                    //       ),
                    //     );
                    //   }
                    // }).catchError((error, stackTrace) {
                    //   Fluttertoast.showToast(msg: authProvider.LoginError);
                    //   authProvider.handleException();
                    // });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff5429FF)),
                    height: 44,
                    child: Center(
                      child: Text(
                        "Signup",
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
          ),
        ),
      ),
    );
  }
}
