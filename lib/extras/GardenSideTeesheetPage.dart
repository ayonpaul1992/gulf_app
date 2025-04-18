import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gulf_app/components/custom_app_bar.dart';
import 'package:gulf_app/components/custom_drawer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class GardenSideTeesheetPage extends StatefulWidget {
  final String gsTeeSheetuserId; // ✅ Add this
  const GardenSideTeesheetPage(
      {super.key, required this.gsTeeSheetuserId}); // ✅ Fix constructor

  @override
  State<GardenSideTeesheetPage> createState() => _GardenSideTeesheetPageState();
}

class _GardenSideTeesheetPageState extends State<GardenSideTeesheetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final TextEditingController _dateController = TextEditingController();
  bool isLoading = false;
  String? nomineedobError;
  DateTime? _selectedDate;
  void _showDatePicker(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Align(
          alignment: const FractionalOffset(0.5, 0.42),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              // Your existing Container code for the calendar goes here
              height: 400,
              width: MediaQuery.of(context).size.width, // Make it full width
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20),top: Radius.circular(20)), // Rounded bottom
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 2), // Shadow at the bottom
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    backgroundColor: Colors.white,
                    selectionColor: Color(0xFF9ECF9A),
                    todayHighlightColor: Color(0xFF9ECF9A),
                    startRangeSelectionColor: Colors.white,
                    endRangeSelectionColor: Colors.white,
                    rangeSelectionColor: Colors.white,
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: Colors.transparent,
                      textStyle: GoogleFonts.poppins(
                          color: Color(0xFF3F4B4B),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      setState(() {
                        _selectedDate = args.value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Adjusted horizontal padding for better visual
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 1.5, color: Color(0xFF9ECF9A)),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF244065),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      TextButton(
                        onPressed: () {
                          if (_selectedDate != null) {
                            final formattedDate = DateFormat("MMM dd, yyyy").format(_selectedDate!);
                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          }
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF9ECF9A),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Adjusted horizontal padding for better visual
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 1.5, color: Color(0xFF9ECF9A)),
                          ),
                        ),
                        child: Text("OK",
                            style: GoogleFonts.poppins(
                                color: Color(0xFFFFFFFF), fontSize: 14,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  int? editingIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        userId: widget.gsTeeSheetuserId, // ✅ Pass the correct userId
        showLeading: false, // ✅ This should prevent the back button
      ),
      drawer: CustomDrawer(
        activeTile: 'Home',
        onTileTap: (selectedTile) {
          //print("Navigating to $selectedTile");
          // Handle navigation logic
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          color: Color(0xFFFAFCFA),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: GoogleFonts.poppins(
                              color: Color(0xFF6E7373),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Custom Date",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF6E7373),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 7),
                              GestureDetector(
                                onTap: editingIndex == null ? () => _showDatePicker(context) : null,
                                child: Container(
                                  child: Row(
                                    children: [
                                      // Text(
                                      //   _dateController.text.isNotEmpty
                                      //       ? _dateController.text
                                      //       : "",
                                      //   style: TextStyle(color: Color(0xFF648683), fontSize: 14),
                                      // ),
                                      Icon(Icons.calendar_month_outlined,
                                          color: Color(0xFF648683), size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (nomineedobError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, left: 12),
                          child: Text(
                            nomineedobError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                  color: Color(0xFF9ECF9A),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10,),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      _dateController.text.isNotEmpty ? "Today\n${_dateController.text}" : "Select\nDate",
                                      style: GoogleFonts.poppins(color: Color(0xFFFFFFFF), fontSize: 14,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
