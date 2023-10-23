import 'package:first_open_project/SendMoneyPages/sendMoneyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ContactPages/contactPage.dart';
import '../ReloadPages/reloadPage1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('name') ?? '';
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            buildProfileTile(),
            const SizedBox(height: 15),
            cards(),
            const SizedBox(height: 15),
            pages(context),
          ],
        ),
      ),
    );
  }

  Widget buildProfileTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/ellipse.png'),
              ),
              const SizedBox(width: 11),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 50.0),
                    child: Text('Welcome back',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ),
                  userName.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(userName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600)),
                  )
                      : Container()
                ],
              ),
              const SizedBox(width: 50),
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {},
                child: const Icon(Icons.notifications, color: Color(0xFF57435C)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cards() {
    PageController controller = PageController(viewportFraction: 0.8);
    return Container(
      height: 250,
      // color: Colors.redAccent,
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 239,
              width: double.infinity,
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
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
                              child: Text('Balance',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white30))),
                          const Positioned(
                              top: 92,
                              left: 24,
                              child: Text('\$4.664,63',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white))),
                          const Positioned(
                              top: 138,
                              left: 24,
                              child: Text('**** 2468',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white30))),
                          const Positioned(
                              top: 140,
                              right: 29,
                              child: Text('12/24',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SmoothPageIndicator(
              controller: controller,
              count: 8,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xFF543B58),
                dotColor: Colors.black26,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pages(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SendMoneyHomePage()));
              },
              child: Container(
                width: 156,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    // width: 1
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset('assets/images/send_money.png'),
                    const SizedBox(height: 12),
                    const Text('Send money',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Text('Take acc to acc',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                payThebill(context);
              },
              child: Container(
                width: 156,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    // width: 1
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset('assets/images/pay_the_bill.png'),
                    const SizedBox(height: 12),
                    const Text('Pay the bill',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Text('Lorem ipsum',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 156,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    // width: 1
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset('assets/images/request.png'),
                    const SizedBox(height: 12),
                    const Text('Request',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Text('Lorem ipsum',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                const ContactPage();
              },
              child: Container(
                width: 156,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    // width: 1
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset('assets/images/contact.png'),
                    const SizedBox(height: 12),
                    const Text('Contact',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Text('Lorem ipsum',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void payThebill(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
              height: 550,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                                color: Colors.white),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ),
                      const SizedBox(width: 43),
                      const Text(
                        'Pay the bill',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 156,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              // width: 1
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.asset('assets/images/send_money.png'),
                              const SizedBox(height: 12),
                              const Text('e-Wallet',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text('Lorem ipsum',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 156,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              // width: 1
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.asset('assets/images/pay_the_bill.png'),
                              const SizedBox(height: 12),
                              const Text('Credit and data',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text('Lorem ipsum',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 156,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              // width: 1
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.asset('assets/images/bill_payment.png'),
                              const SizedBox(height: 12),
                              const Text('Bill payment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text('Lorem ipsum',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 156,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              // width: 1
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.asset('assets/images/contact.png'),
                              const SizedBox(height: 12),
                              const Text('Donation',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text('Lorem ipsum',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 156,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                              // width: 1
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ReloadPage1()));
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Image.asset('assets/images/reload.png'),
                                const SizedBox(height: 12),
                                const Text('Reload',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                const Text('Lorem ipsum',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black38)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ));
        });
  }
}
