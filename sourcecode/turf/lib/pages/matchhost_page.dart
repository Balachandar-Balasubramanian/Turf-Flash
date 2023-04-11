import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turf/models/match.dart';
import 'package:turf/models/models.dart';
import '../constants/constants.dart';
import '../providers/providers.dart';
import 'pages.dart';

late List<String> list;
late String dropdownValue;
late DateFormat dateFormat;
String customerId = '';
String customerName = '';
late SettingProvider settingProvider;
late MatchProvider matchProviders;

class HostMatchPage extends StatefulWidget {
  const HostMatchPage({super.key});

  @override
  State<HostMatchPage> createState() => _HostMatchPageState();
}

class _HostMatchPageState extends State<HostMatchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MatchProvider matchProvider = context.read<MatchProvider>();
    matchProviders = context.read<MatchProvider>();
    list = <String>[
      'Tunit,Guduvanchery',
      'LG Arena,Selaiyur',
      'Tusslez,Perungaluthur',
      'El Clasico,Selaiyur'
    ];
    dropdownValue = list.elementAt(0);
    settingProvider = context.read<SettingProvider>();
    readLocal();
  }

  void readLocal() {
    setState(() {
      customerId = settingProvider.getPref(FirestoreConstants.id) ?? "";
      customerName = settingProvider.getPref(FirestoreConstants.nickname) ?? "";
      print("customer:" + customerId + " " + customerName);
    });
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
    String team = "";
    DateTime _selectedDate = DateTime.now().add(Duration(days: 2));
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String time = "";
    String PhoneNumber = "";
    String turfName = "";
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 40,

        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Game Time!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Location",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        Text('Select a Location',
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
                        turfName = value as String;
                        turfName = selectedValue!;
                        print(turfName);
                      });
                    },
                    buttonHeight: 60,
                    dropdownMaxHeight: 200,
                    buttonWidth: double.infinity,
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
                    dropdownWidth: 350,
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
                  height: 20,
                ),
                Text("Date",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now().add(Duration(days: 2)),
                  selectionColor: Colors.blue,
                  onDateChange: (SelectedDate) {
                    setState(() {
                      _selectedDate = SelectedDate;
                      print(dateFormat.format(_selectedDate));
                      // updateavailable();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Team Name",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    team = value;
                    print(team);
                  },
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 17, color: Color(0xff707070)),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "TEAM"),
                ),
                // Text(time),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),

                Text("Time",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    time = value;
                    print(time);
                  },
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 17, color: Color(0xff707070)),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "4PM-5PM"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Phone Number",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    PhoneNumber = value;
                    print(PhoneNumber);
                  },
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 17, color: Color(0xff707070)),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD0D5DD)),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "1234567"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    print(team);
                    print("time" + time);
                    Matches currentMatch = Matches(
                        teamName: team,
                        customerId: customerId,
                        customerName: customerName,
                        date: dateFormat.format(_selectedDate),
                        time: time,
                        PhoneNumber: PhoneNumber,
                        turfName: selectedValue ?? "College");
                    // currentMatch.turfName = turfName;
                    await matchProviders.uploadBookingFireStore(
                        FirestoreConstants.pathMatchesCollection, currentMatch);
                    print("Sucess");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingConfirmationPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff5429FF)),
                    height: 44,
                    child: Center(
                      child: Text(
                        "POST!!",
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
