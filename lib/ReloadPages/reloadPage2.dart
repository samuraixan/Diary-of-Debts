import 'package:first_open_project/ReloadPages/reloadContact.dart';
import 'package:flutter/material.dart';

class ReloadPage2 extends StatefulWidget {
  const ReloadPage2({super.key});

  @override
  State<ReloadPage2> createState() => _ReloadPage2State();
}

class _ReloadPage2State extends State<ReloadPage2> {
  List<String> selectedNumbers = [];

  String dropdownValue = 'USD';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 0.1),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              const Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Reload',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 0.1),
                  ),
                  child: const Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Container(
                  height: 64,
                  width: 64,
                  child: Image.asset('assets/images/uMobile.png',
                      fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: 327,
              height: 82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 16),
                        border: InputBorder.none,
                        hintText: 'Enter phone number...',
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: 327,
              height: 82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 16),
                        border: InputBorder.none,
                        hintText: 'Enter Amount',
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          Container(
              height: 46,
              width: 327,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F3D56)),
                  child: const Text(
                    'Confirmation',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ))),
          const SizedBox(height: 220),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              width: 148,
              height: 5,
            ),
          ),
        ],
      ),
    );
  }
}
