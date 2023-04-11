import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turf/constants/constants.dart';
import 'package:turf/models/book.dart';

import '../providers/providers.dart';
import 'pages.dart';

class BookConfirm extends StatefulWidget {
  BookingTurf currentBook;
  BookConfirm({super.key, required this.currentBook});

  @override
  State<BookConfirm> createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  late BookProvider bookProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookProvider = context.read<BookProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff1e1d39),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  "Confirm your Booking",
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      // color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Card(
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Name: ",
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.currentBook.customerName,
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Turf Name: ",
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.currentBook.turfName.toUpperCase(),
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Slot Date: ",
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.currentBook.date.toUpperCase(),
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Slots Selected: ",
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.currentBook.slots
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(',', '\n')
                                .replaceAll(']', '')
                                .trim(),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Total Price:  ",
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.currentBook.price.toString(),
                            style: GoogleFonts.lato(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () async {
                await bookProvider.uploadBookingFireStore(
                    FirestoreConstants.pathBookingsCollection,
                    widget.currentBook);
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
                    color: Color(0xff6f61e8)),
                height: 44,
                width: 150,
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
    );
  }
}
