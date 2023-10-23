import 'dart:io';

import 'package:first_open_project/ApiClient.dart';
import 'package:first_open_project/LoginPages/sign_up_page.dart';
import 'package:first_open_project/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_pages_model/login_user_response_model.dart';
import 'forgot_password1.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final apiClient = ApiClient();
  final storage = const FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool isChecked = false;
  bool loading = false;

  String userResponse = '';

  // Эта функция использует secure storage для сохранения email и пароля
  void setRememberMe() async {
    if (isChecked) {
      await storage.write(key: 'email', value: emailController.text.trim());
      await storage.write(
          key: 'password', value: passwordController.text.trim());
    } else {
      await storage.delete(key: 'email');
      await storage.delete(key: 'password');
    }
  }

  // Эта функция использует secure storage для получения email и пароля
  void getRememberMe() async {
    String? email = await storage.read(key: 'email');
    String? password = await storage.read(key: 'password');

    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
      setState(() {
        isChecked = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const SizedBox(width: 24),
                    Container(
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
                    const SizedBox(width: 60),
                    const Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Hi, Welcome Back! 👋',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Text('Lorem ipsum dolor sit amet, consectetur'),
                  ),
                ),
                const SizedBox(height: 15),
                Center(child: emailField()),
                const SizedBox(height: 10),
                Center(child: passwordField()),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text('Remember Me',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 83),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ForgotPassword1()));
                        },
                        child: const Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: signInButton()),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: 245,
                    height: 24,
                    child: Row(
                      children: [
                        const Text('Don’t have an account? ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(43, 121, 121, 1))),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: const BoxDecoration(
                                color: Color(0xFFECF1F6),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/Google.png'),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email Address',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: emailController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
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
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Passwoord',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter your passwoord',
              hintStyle: const TextStyle(color: Colors.black54),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _obscureText = !_obscureText;
                    },
                  );
                },
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black),
              ),
            ),
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
    );
  }

  Widget signInButton() {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(79, 61, 86, 1)),
        onPressed: () async {
          setRememberMe();
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            var response = await apiClient.loginUser(
                emailController.text.trim(), passwordController.text.trim());
            LoginUserResponse loginUserResponse =
                LoginUserResponse.fromJson(response);
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.setString('token', loginUserResponse.data?.token ?? '');
            await preferences.setInt('id', loginUserResponse.data?.user?.id ?? 0);
            await preferences.setString('name', loginUserResponse.data?.user?.name ?? '');
            await preferences.setString('email', loginUserResponse.data?.user?.email ?? '');
            await preferences.setString('phoneNumber', loginUserResponse.data?.user?.phoneNumber ?? '');
            setState(() {
              loading = false;
            });
            if (loginUserResponse.success == true) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            } else if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Incorrect email or password'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ))
            : const Text(
                'Sign In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
