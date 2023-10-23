import 'package:first_open_project/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Проверка, зарегистрирован ли пользователь.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF57435C)),
      ),
      home: token == null ? SignInPage() : MyHomePage(),
    ),
  );
}
