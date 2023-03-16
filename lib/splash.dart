/* Paul Vincent E. Llesol
Team: 
Project Name: Siksik Labuyo
Feature: [LBYO-1001] Splash Screen
Feature description: Splash Screen which displays the logo of Siksik Labuyo before proceeding to the main screen.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:siksik_labuyo/view/screens/main_screen.dart';
import 'firebase/firebase_options.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red.shade700,
                      Colors.redAccent,
                      Colors.redAccent,
                      Colors.red.shade700,
                    ],
                  ),
                ),
                width: double.infinity,
                height: 125,
                alignment: Alignment.center,
                child: Text('Siksik Labuyo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.anton(
                      color: Colors.white,
                      fontSize: 30,
                    )))));
  }
}
