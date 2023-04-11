import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/models/Turf.dart';
import 'package:turf/providers/providers.dart';

import 'package:turf/widgets/widgets.dart';

late List<String> list;
late String dropdownValue;

class BookBody extends StatefulWidget {
  const BookBody({super.key});

  @override
  State<BookBody> createState() => _BookBodyState();
}

class _BookBodyState extends State<BookBody> {
  late TurfProvider turfProvider;
  final ScrollController listScrollController = ScrollController();
  void initState() {
    list = <String>['One', 'Two', 'Three', 'Four'];
    dropdownValue = list.elementAt(0);
    turfProvider = context.read<TurfProvider>();
  }

  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Color(0xff707070))),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (list.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(
                      width: 7,
                    ),
                    Text('Type',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Color(0xff707070))),
                  ],
                ),
                items: _addDividersAfterItems(list),
                customItemsHeights: _getCustomItemsHeights(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                buttonHeight: 40,
                dropdownMaxHeight: 200,
                buttonWidth: 120,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.white,
                ),
                // buttonElevation: 2,
                itemHeight: 40,
                // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                // dropdownMaxHeight: 200,
                dropdownWidth: 120,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                // offset: const Offset(-20, 0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: turfProvider
                  .getStreamFireStore(FirestoreConstants.pathTurfCollection),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      controller: listScrollController,
                    );
                  } else {
                    return Center(
                      child: Text("No Turf"),
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? document) {
    // List<String> recent = [];

    if (document != null) {
      // print(document.get("ImagesURL"));
      // recent = homeProvider.getPref(FirestoreConstants.recentChat);
      // print((recent.length));
// userChat.id == currentUserId || !recent.contains(userChat)
      Turf turf = Turf.fromDocument(document);
      turf.ImagesURL = document.get("ImagesURL");
      // print(turf.ImagesURL);
      // flagchat = false;
      return BookPost(turf: turf);
    } else {
      return SizedBox.shrink();
    }
  }
}
