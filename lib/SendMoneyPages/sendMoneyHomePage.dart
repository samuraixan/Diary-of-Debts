import 'package:flutter/material.dart';

import 'allPage.dart';
import 'bankPage.dart';
import 'eWalletPAge.dart';
import 'favoritaPage.dart';

class SendMoneyHomePage extends StatefulWidget {
  const SendMoneyHomePage({super.key});

  @override
  State<SendMoneyHomePage> createState() => _SendMoneyHomePageState();
}

class _SendMoneyHomePageState extends State<SendMoneyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = const [
    Tab(text: 'All'),
    Tab(text: 'Favorite'),
    Tab(text: 'Bank'),
    Tab(text: 'e-Wallet'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 35),
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
              const Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Send money',
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
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: TextField(
                onChanged: (value) {
                  // filterContacts(value);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 17, horizontal: 16),
                  border: InputBorder.none,
                  hintText: 'Search contact...',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black12,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black26,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: _tabs,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const[
                AllPage(),
                FavoritePage(),
                BankPage(),
                EWalletPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
