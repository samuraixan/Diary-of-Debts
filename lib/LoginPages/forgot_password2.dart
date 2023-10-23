import 'package:flutter/material.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key});

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          color: Colors.white),
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
                  Column(
                    children: [
                      Text('Create a',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600)),
                      Text('New Password',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Enter your new password',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38)),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: 327,
                height: 82,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirm Password',
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
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 16),
                            border: InputBorder.none,
                            hintText: 'Confirm your password',
                            hintStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            InkWell(
              onTap: () {
                forgotPasswordSucces(context);
              },
              child: Center(
                child: Container(
                  height: 48,
                  width: 327,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF4F3D56),
                  ),
                  child: const Center(
                      child: Text('Next',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white))),
                ),
              ),
            ),
            const SizedBox(height: 185),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                width: 148,
                height: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void forgotPasswordSucces(BuildContext context) {
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
                        child: Image.asset('assets/images/succes.png'),
                      )),
                  const Text('Success', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  const Text('Your password is succesfully created', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {
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
        });
  }
}
