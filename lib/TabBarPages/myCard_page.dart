import 'package:flutter/material.dart';


class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  // String cardNumber = '5555 5555 5555 5555';
  // String expiryDate = '12/25';
  // String cardHolderName = 'Osama Qureshi';
  // String cvvCode = '123';
  // bool isCvvFocused = false;
  // bool useGlassMorphism = false;
  // bool useBackgroundImage = false;
  // OutlineInputBorder? border;
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   border = OutlineInputBorder(
  //       borderSide: BorderSide(
  //         color: Colors.grey.withOpacity(0.7),
  //         width: 2,
  //       )
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 24),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.black),
              ),
              const SizedBox(width: 60),
              const Text('All Cards',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
              const SizedBox(width: 60),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                child: const Icon(Icons.more_horiz, size: 30,
                    color: Colors.black),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  List<Color> cardColors = [
                    const Color(0xFF4F3D56),
                    Colors.black,
                    Colors.green,
                    Colors.indigoAccent,
                    Colors.purpleAccent,
                    Colors.yellow,
                    Colors.tealAccent,
                    Colors.indigo
                  ];
                  Color cardColor = cardColors[index % cardColors.length];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cardColor,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 26,
                              right: 29,
                              child: Image.asset('assets/images/visa.png')),
                          Positioned(
                              top: 24,
                              left: 24,
                              child: Image.asset('assets/images/xcard.png')),
                          const Positioned(
                              top: 62,
                              left: 24,
                              child: Text('Balance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white30))),
                          const Positioned(
                              top: 92,
                              left: 24,
                              child: Text('\$4.664,63', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white))),
                          const Positioned(
                              top: 138,
                              left: 24,
                              child: Text('**** 2468', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white30))),
                          const Positioned(
                              top: 140,
                              right: 29,
                              child: Text('12/24', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              width: 327,
              height: 46,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Цвет фона
                  foregroundColor: Colors.black, // Цвет текста
                  shape: RoundedRectangleBorder( // Форма кнопки
                    borderRadius: BorderRadius.circular(20), // Скругление углов
                    side: BorderSide(color: Colors.grey), // Цвет границы
                  ),
                ),
                child: Text('Add Card'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
