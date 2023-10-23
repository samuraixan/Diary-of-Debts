import 'package:flutter/material.dart';

class BoardPage2 extends StatefulWidget {
  const BoardPage2({super.key});

  @override
  State<BoardPage2> createState() => _BoardPage2State();
}

class _BoardPage2State extends State<BoardPage2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF57435C), Color(0xFF130C2A)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(right: 45.0),
              child: Text(
                'Simple and easy\nto control your\nmoney',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Text('Semper in cursus magna et eu varius\nnunc adipiscing. Elementum justo,\nlaoreet id sem semper parturient.  ', style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Container(
                child: Image.asset(
                  'assets/images/money2.png',
                  width: 471,
                  height: 475,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
