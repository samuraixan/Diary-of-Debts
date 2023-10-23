import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiClient.dart';
import '../models/login_pages_model/register_responce_model.dart';
import 'otp_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool isChecked = false;
  bool loading = false;

  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Row(
                children: [
                  const SizedBox(width: 24),
                  InkWell(
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
                  const SizedBox(width: 60),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              // const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: Text('Lorem ipsum dolor sit amet, consectetur'),
                ),
              ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(color: Colors.black54),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a name';
                        } else if (value.length < 3) {
                          return 'Enter your real name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email Address',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Enter your email address',
                        hintStyle: const TextStyle(color: Colors.black54),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the email';
                        } else if (!value.contains('@')) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Passwoord',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter your passwoord',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the password';
                        } else if (value.length < 8) {
                          return 'The password must be at least 8 characters long';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  width: 327,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(79, 61, 86, 1)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        var response = await apiClient.registerUser(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            passwordController.text.trim(),
                        );
                        RegisterResponce r = RegisterResponce.fromJson(response);
                        setState(() {
                          loading = false;
                        });
                        if (r.success == true) {
                          apiClient.otpGenerate(emailController.text.trim());
                          // Сохранение состояния пользователя.
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('token', r.data!.token!);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const OtpPage(),
                              settings: RouteSettings(arguments: r)));
                        } else if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email already exists.'))
                          );
                        }
                      }
                    },
                    child: loading ? const Center(child: CircularProgressIndicator(backgroundColor: Colors.white))
                        : const Text(
                      'Create An Account',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 62,
                    height: 1,
                    color: const Color(0xFFE3E9ED),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Or Sign In with',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9CA4AB)),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 62,
                    height: 1,
                    color: const Color(0xFFE3E9ED),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                          color: Color(0xFFECF1F6),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/Google.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                            color: Color(0xFFECF1F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Apple.png'),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                            color: Color(0xFFECF1F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Group.png'),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By signing up you agree to our ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[700]),
                  ),
                  Text('Terms',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[900]))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('and ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[700])),
                  Text('Conditions of Use',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[900]))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
