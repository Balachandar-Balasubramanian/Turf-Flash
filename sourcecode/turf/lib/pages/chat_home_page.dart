import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf/constants/app_constants.dart';
import 'package:turf/constants/color_constants.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/providers/providers.dart';
import 'package:turf/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';
import 'pages.dart';
import 'search_page.dart';

class ChatHomePage extends StatefulWidget {
  ChatHomePage({Key? key}) : super(key: key);

  @override
  State createState() => ChatHomePageState();
}

bool flagchat = true;

class ChatHomePageState extends State<ChatHomePage> {
  ChatHomePageState({Key? key});

  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;
  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> btnClearController = StreamController<bool>();
  TextEditingController searchBarTec = TextEditingController();

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
    // registerNotification();
    // configLocalNotification();
    listScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    btnClearController.close();
  }

  // void registerNotification() {
  //   firebaseMessaging.requestPermission();

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('onMessage: $message');
  //     if (message.notification != null) {
  //       showNotification(message.notification!);
  //     }
  //     return;
  //   });

  //   firebaseMessaging.getToken().then((token) {
  //     print('push token: $token');
  //     if (token != null) {
  //       homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection, currentUserId, {'pushToken': token});
  //     }
  //   }).catchError((err) {
  //     Fluttertoast.showToast(msg: err.message.toString());
  //   });
  // }

  // void configLocalNotification() {
  //   AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('app_icon');

  //   InitializationSettings initializationSettings = InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  // void showNotification(RemoteNotification remoteNotification) async {
  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     Platform.isAndroid
  //         ? 'com.dfa.flutterchatdemo'
  //         : 'com.duytq.flutterchatdemo',
  //     'Flutter chat demo',
  //     playSound: true,
  //     enableVibration: true,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   IOSNotificationDetails iOSPlatformChannelSpecifics =
  //       IOSNotificationDetails();
  //   NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   print(remoteNotification);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     remoteNotification.title,
  //     remoteNotification.body,
  //     platformChannelSpecifics,
  //     payload: null,
  //   );
  // }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: ColorConstants.themeColor,
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: ColorConstants.primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: ColorConstants.primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text(
                      'Yes',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        // actions: <Widget>[buildPopupMenu()],
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.pink[50]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ADD USER",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FaIcon(
                    FontAwesomeIcons.searchengin,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // List
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // buildSearchBar(),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: homeProvider.getStreamFireStore(
                        FirestoreConstants.pathUserCollection,
                        _limit,
                        _textSearch),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if ((snapshot.data?.docs.length ?? 0) > 0) {
                          List<String> r = homeProvider
                              .getPref(FirestoreConstants.recentChat);
                          if (r.length == 0) {
                            // ignore: prefer_const_constructors
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 500,
                                    child: SvgPicture.asset(
                                        'assets/svg/chat.svg',
                                        semanticsLabel: 'Acme Logo'),
                                  ),
                                  Text(
                                    "SEARCH AN FRND TO START CHATING",
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemBuilder: (context, index) =>
                                buildItem(context, snapshot.data?.docs[index]),
                            itemCount: snapshot.data?.docs.length,
                            controller: listScrollController,
                          );
                        } else {
                          return Center(
                            child: Text("No users"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.themeColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            // Loading
            Positioned(
              child: isLoading ? LoadingView() : SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
      icon: Icon(Icons.adaptive.more, color: ColorConstants.themeColor),
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((PopupChoices choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.themeColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(color: ColorConstants.themeColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }

  List<String> recent = [];
  Widget buildItem(BuildContext context, DocumentSnapshot? document) {
    // List<String> recent = [];

    if (document != null) {
      recent = homeProvider.getPref(FirestoreConstants.recentChat);
      print((recent.length));
// userChat.id == currentUserId || !recent.contains(userChat)
      UserChat userChat = UserChat.fromDocument(document);
      if (userChat.id == currentUserId || !recent.contains(userChat.id)) {
        return SizedBox.shrink();
      } else {
        flagchat = false;
        return Container(
          child: TextButton(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(userChat.photoUrl),
                        maxRadius: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userChat.nickname,
                                style: TextStyle(
                                    fontSize: 19, color: Colors.black),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                userChat.aboutMe == ""
                                    ? "Hey there!!"
                                    : userChat.aboutMe,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   children: <Widget>[
            //     CircleAvatar(
            //       radius: 22,
            //       child: Material(
            //         child: userChat.photoUrl.isNotEmpty
            //             ? Image.network(
            //                 userChat.photoUrl,
            //                 fit: BoxFit.cover,
            //                 width: 50,
            //                 height: 50,
            //                 loadingBuilder: (BuildContext context, Widget child,
            //                     ImageChunkEvent? loadingProgress) {
            //                   if (loadingProgress == null) return child;
            //                   return Container(
            //                     width: 50,
            //                     height: 50,
            //                     child: Center(
            //                       child: CircularProgressIndicator(
            //                         color: ColorConstants.themeColor,
            //                         value: loadingProgress.expectedTotalBytes !=
            //                                 null
            //                             ? loadingProgress
            //                                     .cumulativeBytesLoaded /
            //                                 loadingProgress.expectedTotalBytes!
            //                             : null,
            //                       ),
            //                     ),
            //                   );
            //                 },
            //                 errorBuilder: (context, object, stackTrace) {
            //                   return Icon(
            //                     Icons.account_circle,
            //                     size: 50,
            //                     color: ColorConstants.greyColor,
            //                   );
            //                 },
            //               )
            //             : Icon(
            //                 Icons.account_circle,
            //                 size: 50,
            //                 color: ColorConstants.greyColor,
            //               ),
            //         borderRadius: BorderRadius.all(Radius.circular(25)),
            //         clipBehavior: Clip.hardEdge,
            //       ),
            //     ),
            //     Flexible(
            //       child: Container(
            //         child: Column(
            //           children: <Widget>[
            //             Container(
            //               child: Text(
            //                 '${userChat.nickname.toUpperCase()}',
            //                 maxLines: 1,
            //                 style: TextStyle(color: Colors.black, fontSize: 15),
            //               ),
            //               alignment: Alignment.centerLeft,
            //               margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
            //             ),
            //             Container(
            //               child: Text(
            //                 userChat.aboutMe == ""
            //                     ? "Hey There! I'm using turf flash"
            //                     : userChat.aboutMe,
            //                 maxLines: 1,
            //                 style: TextStyle(color: Colors.black38),
            //               ),
            //               alignment: Alignment.centerLeft,
            //               margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            //             )
            //           ],
            //         ),
            //         margin: EdgeInsets.only(left: 20),
            //       ),
            //     ),
            //   ],
            // ),
            onPressed: () {
              if (Utilities.isKeyboardShowing()) {
                Utilities.closeKeyboard(context);
              }
              print("Open chat");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    arguments: ChatPageArguments(
                      peerId: userChat.id,
                      peerAvatar: userChat.photoUrl,
                      peerNickname: userChat.nickname,
                    ),
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }
}
