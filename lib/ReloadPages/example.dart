import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Example extends StatelessWidget {
    Example({super.key});
  String dropdownValue = 'USD';

  List<String> selectedNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    reload3(context);
                  },
                  child: const Text('Confirmation'))),
        ],
      ),
    );
  }

  void reload3(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: 550,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.black, width: 0.1)),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 72,
                          width: 327,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1)),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                  Border.all(width: 1, color: Colors.black12),
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
                                      ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 184,
                                child: FittedBox(
                                  child: Text(
                                    selectedNumbers.join(),
                                    style: const TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        buildNumberContainer('1'),
                        buildNumberContainer('2'),
                        buildNumberContainer('3'),
                      ],
                    ),
                    Row(
                      children: [
                        buildNumberContainer('4'),
                        buildNumberContainer('5'),
                        buildNumberContainer('6'),
                      ],
                    ),
                    Row(
                      children: [
                        buildNumberContainer('7'),
                        buildNumberContainer('8'),
                        buildNumberContainer('9'),
                      ],
                    ),
                    Row(
                      children: [
                        buildNumberContainer(','),
                        buildNumberContainer('0'),
                        buildDeleteButton(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 46,
                      width: 327,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          onPressed: () {
                            reloadSucces(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4F3D56)),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  Widget buildNumberContainer(String number) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedNumbers.add(number);
            });
          },
          child: Container(
            height: 64,
            width: 99,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.black12),
            ),
            child: Center(
                child: Text(
                  number,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                )),
          ),
        ),
      );}
    );
  }

  Widget buildDeleteButton() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedNumbers.isNotEmpty) {
                    selectedNumbers.removeLast();
                  }
                });
              },
              onLongPress: () {
                setState(() {
                  selectedNumbers.clear();
                });
              },
              child: Container(
                height: 64,
                width: 99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: const Center(child: Icon(Icons.arrow_back_ios_new)),
              ),
            ),
          );
        }
    );
  }

  void reloadSucces(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 327,
            height: 324,
            // color: Colors.black38,
            child: Column(
              children: [
                SizedBox(
                    height: 148,
                    width: 148,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 34.0),
                      child: Image.asset('assets/images/reloadSuccess.png'),
                    )),
                const Text('Your reload is succesfully sent',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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
      },
    );
  }
}
