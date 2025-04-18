import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gulf_app/components/custom_app_bar.dart';
import 'package:gulf_app/components/custom_drawer.dart';

class GreaterTeesheetPage extends StatefulWidget {
  final String gTeeSheetuserId; // ✅ Add this
  const GreaterTeesheetPage({super.key, required this.gTeeSheetuserId});

  @override
  State<GreaterTeesheetPage> createState() => _GreaterTeesheetPageState();
}

class _GreaterTeesheetPageState extends State<GreaterTeesheetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        userId: widget.gTeeSheetuserId, // ✅ Pass the correct userId
        showLeading: false, // ✅ This should prevent the back button
      ),
      body: const Center(child: Text("This is Greater Teesheet Page")),
    );
  }
}
