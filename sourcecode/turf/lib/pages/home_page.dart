import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/pages/body/book_body.dart';

import '../providers/providers.dart';
import 'pages.dart';
import 'body/body.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _loginState();
}

class _loginState extends State<HomePage> {
  late AuthProvider authProvider;
  late String currentUserId;
  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';

  bool isLoading = false;
  late SettingProvider settingProvider;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeBody(),
    BookBody(),
    MatchBody(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //PostsStream();
    authProvider = context.read<AuthProvider>();
    settingProvider = context.read<SettingProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
      readLocal();
      // user_name = authProvider.getPref(FirestoreConstants.nickname);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void readLocal() {
    setState(() {
      id = settingProvider.getPref(FirestoreConstants.id) ?? "";
      nickname = settingProvider.getPref(FirestoreConstants.nickname) ?? "";
      aboutMe = settingProvider.getPref(FirestoreConstants.aboutMe) ?? "";
      photoUrl = settingProvider.getPref(FirestoreConstants.photoUrl) ?? "";
    });
  }

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool getHostButton() {
      if (_selectedIndex == 2) {
        return true;
      } else {
        return false;
      }
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.symmetric(horizontal: 7),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                    Text(
                      nickname,
                      style: const TextStyle(color: Colors.black, fontSize: 40),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  // color:
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.userPen),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              // ListTile(
              //   title: const Text('Item 1'),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
              GestureDetector(
                onTap: handleSignOut,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  // color:
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.rightFromBracket),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: ColorConstants.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.bgColor,
          titleSpacing: 0.0,
          leading: Builder(
            builder: (context) => MaterialButton(
              onPressed: (() {
                Scaffold.of(context).openDrawer();
              }),
              child: FaIcon(
                FontAwesomeIcons.bars,
                color: Color(0xff5429FF),
              ),
            ),
          ),
          // title: Column(
          //   children: [
          //     const Text(
          //       "Welcome",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     Text(
          //       nickname,
          //       style: const TextStyle(color: Colors.black),
          //     ),
          //   ],
          // ),
          actions: [
            MaterialButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatHomePage()),
                );
              }),
              child: const Icon(
                Icons.quickreply,
                size: 30,
                color: Color(0xff5429FF),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: Visibility(
          visible: getHostButton(),
          child: FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HostMatchPage()),
              );
            },
            label: const Text('Host'),
            icon: const Icon(Icons.sports),
            backgroundColor: Color(0xff5429FF),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.futbol),
              label: 'Book',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.handshakeAngle),
              label: 'Match',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: ColorConstants.bgColor,
          // unselectedItemColor: ColorConstants.themeColor,
          selectedItemColor: Color(0xff5429FF),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
