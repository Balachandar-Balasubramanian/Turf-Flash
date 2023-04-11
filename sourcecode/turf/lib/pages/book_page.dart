import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/pages/pages.dart';
import '../models/models.dart';
import '../providers/providers.dart';

late List<String> _selectedSlots;

class BookPage extends StatefulWidget {
  Turf turf;
  BookPage({
    super.key,
    required this.turf,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late DateTime _selectedDate;
  late DateFormat dateFormat;
  late String fromTime;
  late String toTime;
  String ftime = "00";
  String ttime = "20";
  List<SlotButton> initalList = [
    SlotButton(slot: '00 - 01:00'),
    SlotButton(slot: '01 - 02:00'),
    SlotButton(slot: '02 - 03:00'),
    SlotButton(slot: '03 - 04:00'),
    SlotButton(slot: '04 - 05:00'),
    SlotButton(slot: '05 - 06:00'),
    SlotButton(slot: '06 - 07:00'),
    SlotButton(slot: '07 - 08:00'),
    SlotButton(slot: '08 - 09:00'),
    SlotButton(slot: '09 - 10:00'),
    SlotButton(slot: '10 - 11:00'),
    SlotButton(slot: '11 - 12:00'),
    SlotButton(slot: '12 - 13:00'),
    SlotButton(slot: '13 - 14:00'),
    SlotButton(slot: '14 - 15:00'),
    SlotButton(slot: '15 - 16:00'),
    SlotButton(slot: '16 - 17:00'),
    SlotButton(slot: '17 - 18:00'),
    SlotButton(slot: '18 - 19:00'),
    SlotButton(slot: '19 - 20:00'),
    SlotButton(slot: '20 - 21:00'),
    SlotButton(slot: '21 - 22:00'),
    SlotButton(slot: '22 - 23:00'),
    SlotButton(slot: '23 - 00:00'),
  ];
  late List<SlotButton> availableSlots;
  late BookProvider bookProvider;
  late SettingProvider settingProvider;
  String customerId = '';
  String customerName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 2));
    dateFormat = DateFormat("yyyy-MM-dd");
    fromTime = DateFormat("HH:MM").format(DateTime.now());
    toTime = DateFormat("HH:MM").format(DateTime.now().add(Duration(days: 1)));
    availableSlots = List.from(initalList);
    _selectedSlots = [];
    settingProvider = context.read<SettingProvider>();
    readLocal();
    bookProvider = context.read<BookProvider>();
    updateavailable();

    // readLocal();
  }

  void readLocal() {
    setState(() {
      customerId = settingProvider.getPref(FirestoreConstants.id) ?? "";
      customerName = settingProvider.getPref(FirestoreConstants.nickname) ?? "";
      print("customer:" + customerId + " " + customerName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(_selectedDate.toString()),
              Container(
                height: 300,
                child: SvgPicture.asset('assets/svg/book.svg',
                    semanticsLabel: 'Acme Logo'),
                // child: Image.asset(
                //   'assets/images/BOOKING_IMAGE.jpg',
                //   fit: BoxFit.fill,
                // ),
              ),
              Text("Select a date",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.w600)),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.blue,
                  onDateChange: (SelectedDate) {
                    setState(() {
                      _selectedDate = SelectedDate;
                      updateavailable();
                    });
                  },
                ),
              ),
              // Center(child: Text(dateFormat.format(_selectedDate))),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                              fontSize: 30, fontWeight: FontWeight.w600)),
                      // _getTimeFromUser(isFrom: true),

                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          _getTimeFromUser(isFrom: true);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(5)),
                          height: 40,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  fromTime,
                                  style: TextStyle(color: Colors.black),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.clock,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                              fontSize: 30, fontWeight: FontWeight.w600)),
                      // _getTimeFromUser(isFrom: true),

                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          _getTimeFromUser(isFrom: false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(5)),
                          height: 40,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  toTime,
                                  style: TextStyle(color: Colors.black),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.clock,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("Select a Slot",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.w600)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableSlots.sublist(
                      int.parse(ftime), int.parse(ttime)),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedSlots.length != 0) {
                    BookingTurf currentbooking = BookingTurf(
                        customerId: customerId,
                        turfId: widget.turf.id,
                        customerName: customerName,
                        date: dateFormat.format(_selectedDate),
                        slots: _selectedSlots,
                        price: (_selectedSlots.length) *
                            int.parse(widget.turf.price),
                        turfName: widget.turf.name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookConfirm(
                                  currentBook: currentbooking,
                                )));
                    print(currentbooking.toJson());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue),
                  height: 44,
                  child: Center(
                    child: Text(
                      "Book Slots",
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
    );
  }

  _getTimeFromUser({required bool isFrom}) async {
    TimeOfDay pickedtime = await _showTimePicker();
    pickedtime = pickedtime.replacing(minute: 0);
    // ignore: use_build_context_synchronously
    var hour = pickedtime.hour;
    String formatedTime = pickedtime.format(context);
    if (pickedtime == null) {
      print("Canceled");
    } else if (isFrom) {
      setState(() {
        fromTime = formatedTime;
        print(formatedTime);
        ftime = fromTime.split(":")[0];
        print(ftime);
      });
    } else if (!isFrom) {
      setState(() {
        toTime = formatedTime;
        ttime = toTime.split(":")[0];
        print(ttime);
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
  }

  Future<List<SlotButton>> updateavailable() async {
    List<SlotButton> templist = [];
    templist = List.from(initalList);
    var booked = [];
    // print(widget.turf.id);
    // print(dateFormat.format(_selectedDate));
    Stream<QuerySnapshot> allBooks = bookProvider.getBooksStreamFireStore(
        FirestoreConstants.pathBookingsCollection,
        dateFormat.format(_selectedDate),
        widget.turf.id);
    allBooks.listen((snapshot) {
      print("length:" + snapshot.docs.length.toString());
      for (var i = 0; i < snapshot.docs.length; i++) {
        DocumentSnapshot document = snapshot.docs[i];
        BookingTurf booking = BookingTurf.fromDocument(document);
        // print("SLots:");
        // print(document.get(FirestoreConstants.slots));
        var Strslot = document.get(FirestoreConstants.slots);
        List<String> slot =
            Strslot.replaceAll(RegExp(r'[\[\]"]'), '').split(',');
        print(slot.runtimeType);
        booked = booked + slot;
        print("b: " + booked.length.toString());
      }
      for (var i = 0; i < booked.length; i++) {
        String s = booked[i];
        print("s" + s);
        String hour = s.split(" - ")[0];
        print("index hour" + hour);
        templist.removeAt(int.parse(hour));
        print("temp:" + templist.length.toString());
      }
      setState(() {
        print("all:" + initalList.length.toString());
        availableSlots = List.from(templist);
      });
    });

    print(booked);
    return templist;
  }
}

class SlotButton extends StatefulWidget {
  bool active = false;
  // String slot = "";
  SlotButton({super.key, required this.slot});
  final String slot;

  @override
  State<SlotButton> createState() => _SlotButtonState();
}

class _SlotButtonState extends State<SlotButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!widget.active) {
              _selectedSlots.add(widget.slot);
              widget.active = true;
            } else {
              _selectedSlots.remove(widget.slot);
              widget.active = false;
            }
            print(widget.slot);
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
              color: widget.active ? Colors.blue : Colors.white,
              border: Border.all(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(5)),
          height: 40,
          width: 100,
          child: Center(
              child: Text(
            widget.slot,
            style:
                TextStyle(color: widget.active ? Colors.white : Colors.black),
          )),
        ),
      ),
    );
  }
}
