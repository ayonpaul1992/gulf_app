import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gulf_app/components/custom_app_bar.dart';
import 'package:gulf_app/components/custom_drawer.dart';

class GreaterParTeesheetPage extends StatefulWidget {
  final String gpTeeSheetuserId; // ✅ Add this
  const GreaterParTeesheetPage({super.key, required this.gpTeeSheetuserId}); // ✅ Fix constructor

  @override
  State<GreaterParTeesheetPage> createState() => _GreaterParTeesheetPageState();
}

class _GreaterParTeesheetPageState extends State<GreaterParTeesheetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        userId: widget.gpTeeSheetuserId, // ✅ Pass the correct userId
        showLeading: false, // ✅ This should prevent the back button
      ),
      body: const Center(child: Text("This is Greater Par Teesheet Page")),
    );
  }
}
