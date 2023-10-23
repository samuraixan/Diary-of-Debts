import 'package:first_open_project/ReloadPages/reloadContact.dart';
import 'package:flutter/material.dart';


class ReloadPage1 extends StatefulWidget {
  const ReloadPage1({super.key});

  @override
  State<ReloadPage1> createState() => _ReloadPage1State();
}

class _ReloadPage1State extends State<ReloadPage1> {
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
    contacts.sort((a,b) => a.name.compareTo(b.name));
    return Scaffold(
      body: Column(
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
                      border: Border.all(
                          color: Colors.black,
                          width: 0.1
                      ),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Reload', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.1
                    ),
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
                  child: Image.asset('assets/images/uMobile.png', fit: BoxFit.fill)),
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
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 17, horizontal: 16),
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
                    'All Contact',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        filterContacts(value);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 17, horizontal: 16),
                        border: InputBorder.none,
                        hintText: 'Search contact...',
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isCapitalized = index == 0 || filteredContacts[index].name[0].toUpperCase() !=
                      filteredContacts[index - 1].name[0].toUpperCase();
                  bool isLastItem = index == filteredContacts.length - 1 ||
                      filteredContacts[index].name[0].toUpperCase() !=
                          filteredContacts[index + 1].name[0].toUpperCase();
                  return Column(
                    children: [
                      if (isCapitalized)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(contacts[index].name[0].toUpperCase(),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      contacts[index].favorites == true
                          ?ListTile(
                        leading: Container(
                          height: 48,
                          width: 48,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                child: Image.asset(contacts[index].imagePath ?? ''),
                              ),
                              Positioned(
                                left: 30,
                                bottom: 20,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepPurple
                                  ),
                                  child: const Icon(Icons.star, size: 12, color: Colors.white,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(contacts[index].name),
                        subtitle: Text(contacts[index].phoneNumber),
                      )
                          :ListTile(
                        leading: Container(
                          height: 48,
                          width: 48,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                child: Image.asset(contacts[index].imagePath ?? ''),
                              ),
                            ],
                          ),
                        ),
                        title: Text(contacts[index].name),
                        subtitle: Text(contacts[index].phoneNumber),
                      ),
                      if (!isLastItem)
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
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}



