import 'package:first_open_project/SendMoneyPages/sendInfoPage.dart';
import 'package:flutter/material.dart';

import '../ReloadPages/reloadContact.dart';

class EWalletPage extends StatefulWidget {
  const EWalletPage({super.key});

  @override
  State<EWalletPage> createState() => _EWalletPageState();
}

class _EWalletPageState extends State<EWalletPage> {
  List<Contact> contacts = [
    Contact(name: 'Tiana Saris', phoneNumber: 'BCA • 1468 3545 ***', imagePath: 'assets/images/tiana.png', favorites: false),
    Contact(name: 'Kaiya Baptista', phoneNumber: 'BCA • 2468 3545 ***', imagePath: 'assets/images/kaiya.png', favorites: false),
    Contact(name: 'Desirae Bergson', phoneNumber: 'BCA • 3468 3545 ***', imagePath: 'assets/images/desirae.png', favorites: true),
    Contact(name: 'Emery Schleifer', phoneNumber: 'BCA • 4468 3545 ***', imagePath: 'assets/images/emery.png', favorites: false),
    Contact(name: 'Ruben Rhiel Madsen', phoneNumber: 'BCA • 5468 3545 ***', imagePath: 'assets/images/ellipse.png', favorites: true),
    Contact(name: 'Roger Levin', phoneNumber: 'BCA • 6468 3545 ***', imagePath: 'assets/images/roger.png', favorites: false),
    Contact(name: 'Jaydon Botosh', phoneNumber: 'BCA • 7468 3545 ***', imagePath: 'assets/images/jaydon.png', favorites: false),
    Contact(name: 'Hiana Saris', phoneNumber: 'BCA • 8468 3545 ***', favorites: false),
    Contact(name: 'Hiana Saris', phoneNumber: 'BCA • 9468 3545 ***', favorites: false),
    Contact(name: 'Liana Saris', phoneNumber: 'BCA • 1268 3545 ***', favorites: false),
  ];

  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  void filterContacts(String query) {
    setState(() {
      if(query.isNotEmpty) {
        filteredContacts = contacts.where((contact) {
          return contact.name.toLowerCase().startsWith(query.toLowerCase());
        }).toList();
      } else {
        filteredContacts = contacts;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendInfoPage()));
              },
              child: ListView.builder(
                  itemCount: filteredContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        contacts[index].favorites == false ? ListTile(
                          leading: Container(
                            height: 48,
                            width: 48,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  child: Image.asset(contacts[index].imagePath ?? 'assets/images/ellipse.png'),
                                ),
                              ],
                            ),
                          ),
                          title: Text(contacts[index].name),
                          subtitle: Text(contacts[index].phoneNumber),
                          trailing: const Icon(Icons.star_outline),
                        ) : ListTile(
                          leading: Container(
                            height: 48,
                            width: 48,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  child: Image.asset(contacts[index].imagePath ?? 'assets/images/ellipse.png'),
                                ),
                              ],
                            ),
                          ),
                          title: Text(contacts[index].name),
                          subtitle: Text(contacts[index].phoneNumber),
                          trailing: const Icon(Icons.star, color: Color(0xFF804E89),),
                        ),
                        const Divider(
                          color: Colors.black12,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
