import 'package:flutter/material.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {



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
                    child: Text('Contacts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
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
          SizedBox(
            width: 327,
            height: 82,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: TextField(
                    onChanged: (value) {
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
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFECF1F6),
                ),
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 20),
              const Text('Add Contact', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                ),
                width: 148,
                height: 5,
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}



