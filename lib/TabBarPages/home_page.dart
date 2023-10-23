import 'package:first_open_project/TabBarPages/shop_pages/shop_data.dart';
import 'package:first_open_project/models/shop_pages_model/show_shop_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiClient.dart';
import '../models/shop_pages_model/user_shops_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  final apiClient = ApiClient();
  List shops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserName();
    userShops();
  }

  Future<void> userShops() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, dynamic> response = await apiClient.getShops();
    UserShopsResponse userShopsResponse = UserShopsResponse.fromJson(response);
    if (mounted) {
      setState(() {
        shops = userShopsResponse.data ?? [];
        isLoading = false;
      });
    }
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
      body: Column(
        children: [
          const SizedBox(height: 35),
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
                  child:
                  const Icon(Icons.notifications, color: Color(0xFF57435C)),
                ),
              ],
            ),
          ),
          shops.isEmpty
              ? isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text('Is Empty'))
              : Expanded(
            child: GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: shops.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    var response = await apiClient.showShops(shops[index].id.toString());
                    ShowShopResponse showShopResponse = ShowShopResponse.fromJson(response);
                    var shop = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShopData(shop: shops[index], showShopResponse: showShopResponse,)));
                    if (shop != null) {
                      setState(() {
                        shops[index] = shop;
                      });
                    } else {
                      shops.removeAt(index);
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                        border: Border.all(
                          color: Colors.black12,
                          // width: 1
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          const Icon(
                            Icons.store,
                            color: Color(0xFF57435C),
                            size: 50,
                          ),
                          const SizedBox(height: 12),
                          Text(shops[index].name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(shops[index].address,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
