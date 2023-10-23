import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TabBarPages/add_page.dart';
import 'TabBarPages/home_page.dart';
import 'TabBarPages/myCard_page.dart';
import 'TabBarPages/profile_page.dart';
import 'TabBarPages/statistic_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController?.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            HomePage(),
            StatisticPage(),
            AddPage(),
            MyCardPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(icon: Icon(Icons.home, size: 35,), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.insert_chart, size: 35), label: 'Statistic'),
            BottomNavigationBarItem(
                icon: Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF57435C),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: Icon(Icons.add_box,
                              size: 30, color: Colors.white)),
                    ),
                  ],
                ),
                label: ''),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet, size: 35), label: 'My Card'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 35), label: 'Profil'),
          ],
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 0),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemClicked,
        ),
      ),
    );
  }
}
