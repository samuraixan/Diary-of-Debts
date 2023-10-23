import 'package:flutter/material.dart';

class BoardPage3 extends StatefulWidget {
  const BoardPage3({super.key});

  @override
  State<BoardPage3> createState() => _BoardPage3State();
}

class _BoardPage3State extends State<BoardPage3> {
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
              padding: EdgeInsets.only(right: 45),
              child: Text(
                'Your savings are\nsafe by smat\ninvest',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Text('Semper in cursus magna et eu varius\nnunc adipiscing. Elementum justo,\nlaoreet id sem semper parturient. ', style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0),
              child: Image.asset(
                'assets/images/money3.png',
                height: 475,
                width: 586,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
