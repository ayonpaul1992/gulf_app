import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:gulf_app/components/userentry_app_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'password_confirm.dart';

class resetPasswordPage extends StatefulWidget{
  const resetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState()=>resetPasswordPageState();

}
class resetPasswordPageState extends State<resetPasswordPage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Create a storage instance
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final passText = TextEditingController();
  final repassText = TextEditingController();
  // Function to show the error or success messages
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  key: _scaffoldKey,
  appBar: userentryAppbar(
    scaffoldKey: _scaffoldKey,
    userId: '',
    showLeading: false,
  ),
  body: Container(
    color: Color(0xFFFAFCFA),
    width: double.infinity,
    height: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Quick. Simple. Secure.",
            style: GoogleFonts.poppins(
              color: Color(0xFF669933),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 1,
                      color: Color(0xFFB2C1C0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Reset Password",
                      style: GoogleFonts.poppins(
                          color: Color(0xFF244065),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 1,
                      color: Color(0xFFB2C1C0),
                    ),
                  ],
                )),
          ),
          Padding(
            padding:
            EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 30),
            child: Text(
              "Remember and setup your new password and secure your account.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Color(0xFF6E7373),
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6E7373),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Set background color if needed
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Shadow color
                              blurRadius: 6,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: passText,
                          decoration: _inputDecoration(''),
                          style: const TextStyle(
                            color: Color(0xFF648683),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    Text(
                      'Confirm Password',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6E7373),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Set background color if needed
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Shadow color
                              blurRadius: 6,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: repassText,
                          decoration: _inputDecoration(''),
                          style: const TextStyle(
                            color: Color(0xFF648683),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => passwordConfirmPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9ECF9A)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                "Reset password",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.5,
                        right: 15,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFFFFFFF),
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Color(0xFF9ECF9A),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(
        color: const Color(0xFF6E7373),
        fontSize: 14,
      ),
    );
  }
}