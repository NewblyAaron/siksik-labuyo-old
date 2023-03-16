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
    await Future.delayed(const Duration(hours: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.redAccent,
            width: double.infinity,
            height: 100,
            child: Text('Siksik Labuyo',
                textAlign: TextAlign.center,
                style: GoogleFonts.anton(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2.0,
                ))));
  }
}
