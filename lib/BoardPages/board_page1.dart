import 'package:flutter/material.dart';

class BoardPage1 extends StatefulWidget {
  const BoardPage1({super.key});

  @override
  State<BoardPage1> createState() => _BoardPage1State();
}

class _BoardPage1State extends State<BoardPage1> {
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
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'The best app for manage your\nfinance',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 80),
                child: Text('Semper in cursus magna et eu varius\nnunc adipiscing. '
                    'Elementum justo,\nlaoreet id sem semper parturient. ', style: TextStyle(color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 108.0),
                child: Image.asset(
                  'assets/images/money1.png',
                  height: 475,
                  width: 290,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
