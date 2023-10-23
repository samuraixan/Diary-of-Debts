import 'package:flutter/material.dart';

import 'forgot_password2.dart';

class ForgotPassword1 extends StatefulWidget {
  const ForgotPassword1({super.key});

  @override
  State<ForgotPassword1> createState() => _ForgotPassword1State();
}

class _ForgotPassword1State extends State<ForgotPassword1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
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
                        color: Colors.white
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Column(
              children: [
                Text('Forgot Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text('Recover your account password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black38)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: 327,
              height: 82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email Address',
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
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword2()));
            },
            child: Center(
              child: Container(
                height: 48,
                width: 327,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF4F3D56),
                ),
                child: const Center(child: Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))),
              ),
            ),
          ),
          const SizedBox(height: 312),
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
        ],
      ),
    );
  }
}
