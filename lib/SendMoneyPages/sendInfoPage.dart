import 'package:flutter/material.dart';

import '../ReloadPages/reloadContact.dart';

class SendInfoPage extends StatefulWidget {
  const SendInfoPage({
    super.key,
  });

  @override
  State<SendInfoPage> createState() => _SendInfoPageState();
}

class _SendInfoPageState extends State<SendInfoPage> {
  List<Contact> contacts = [
    Contact(
        name: 'Tiana Saris',
        phoneNumber: 'BCA • 1468 3545 ***',
        imagePath: 'assets/images/tiana.png',
        favorites: false),
    Contact(
        name: 'Kaiya Baptista',
        phoneNumber: 'BCA • 2468 3545 ***',
        imagePath: 'assets/images/kaiya.png',
        favorites: false),
    Contact(
        name: 'Desirae Bergson',
        phoneNumber: 'BCA • 3468 3545 ***',
        imagePath: 'assets/images/desirae.png',
        favorites: true),
    Contact(
        name: 'Emery Schleifer',
        phoneNumber: 'BCA • 4468 3545 ***',
        imagePath: 'assets/images/emery.png',
        favorites: false),
    Contact(
        name: 'Ruben Rhiel Madsen',
        phoneNumber: 'BCA • 5468 3545 ***',
        imagePath: 'assets/images/ellipse.png',
        favorites: true),
    Contact(
        name: 'Roger Levin',
        phoneNumber: 'BCA • 6468 3545 ***',
        imagePath: 'assets/images/roger.png',
        favorites: false),
    Contact(
        name: 'Jaydon Botosh',
        phoneNumber: 'BCA • 7468 3545 ***',
        imagePath: 'assets/images/jaydon.png',
        favorites: false),
    Contact(
        name: 'Hiana Saris',
        phoneNumber: 'BCA • 8468 3545 ***',
        favorites: false),
    Contact(
        name: 'Hiana Saris',
        phoneNumber: 'BCA • 9468 3545 ***',
        favorites: false),
    Contact(
        name: 'Liana Saris',
        phoneNumber: 'BCA • 1268 3545 ***',
        favorites: false),
  ];

  String dropdownValue = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                ),
                const Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 80.0),
                        child: Text('Reload',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/tiana.png'),
                  ),
                  SizedBox(height: 10),
                  Text('Tiana Saris',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text('BCA • 2468 7645 6346',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black26)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Amount:',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Container(
                    height: 72,
                    width: 327,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.3, color: Colors.black38),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset('assets/images/Vector.png'),
                              const SizedBox(width: 5),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                                iconSize: 30,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'USD',
                                  'UZS',
                                  'EUR',
                                  'GBP',
                                  'JPY',
                                  'AED'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 184,
                                child: const TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Message',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    height: 132,
                    width: 327,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.3, color: Colors.black38),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 295,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Thank you for your cooperation :)',
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Center(
              child: Container(
                  height: 46,
                  width: 327,
                  child: ElevatedButton(
                      onPressed: () {
                        confirmTransfer();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F3D56)),
                      child: const Text('Send Money'))),
            )
          ],
        ),
      ),
    );
  }

  void confirmTransfer() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 555,
              width: 327,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black12.withOpacity(0.1),
                          child: Container(
                              height: 48,
                              width: 48,
                              child: Image.asset(
                                  'assets/images/confirmTransfer.png')),
                        ),
                        const SizedBox(height: 20),
                        const Text('Total transfer',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54)),
                        const SizedBox(height: 10),
                        const Text('\$154,42',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('Transfer detail',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('From',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 25.0),
                              child: Text(
                                'e-Wallet • 3446 4655 5445',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('To',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 25.0),
                              child: Text(
                                'BCA • 2468 3545 4534',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('Transfer',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 25.0),
                              child: Text(
                                '\$154,42',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('Admin fee',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: Container(
                              height: 22,
                              width: 46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF804E89)
                              ),
                              child: const Center(
                                child: Text(
                                  'Free',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                        child: Divider(),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('Total transfer',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 25.0),
                              child: Text(
                                '\$154,42',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 55.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                            child: const Text('Cancel', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: ElevatedButton(onPressed: () {
                          confirmTransferSucces(context);
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F3D56)),
                            child: const Text('Confirm', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void confirmTransferSucces(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 327,
              height: 324,
              child: Column(
                children: [
                  SizedBox(
                      height: 148,
                      width: 148,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 34.0),
                        child: Image.asset('assets/images/reloadSuccess.png'),
                      )),
                  const SizedBox(height: 5),
                  const Text('Your transfer is succesfully sent', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black38)),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      failed(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F3D56)),
                    child: Container(
                      height: 46,
                      width: 123,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF4F3D56),
                      ),
                      child: const Center(
                          child: Text('Continue',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void failed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 327,
              height: 374,
              child: Column(
                children: [
                  SizedBox(
                      height: 148,
                      width: 148,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 34.0),
                        child: Image.asset('assets/images/failed.png'),
                      )),
                  const SizedBox(height: 5),
                  const Text('Failed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  const Text('Your transfer is failed because\nof bad networking.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black38)),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F3D56)),
                    child: Container(
                      height: 46,
                      width: 123,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF4F3D56),
                      ),
                      child: const Center(
                          child: Text('Repeat Transfer',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(color: Colors.red))),
                ],
              ),
            ),
          );
        });
  }

}
