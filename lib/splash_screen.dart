import 'dart:async';

import 'package:flutter/material.dart';
import 'LoginPages/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => BoardHome()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF57435C), Color(0xFF130C2A)]
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Mask.png'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Bänkee', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
