import 'package:first_open_project/BoardPages/board_page1.dart';
import 'package:first_open_project/BoardPages/board_page2.dart';
import 'package:first_open_project/BoardPages/board_page3.dart';
import 'package:first_open_project/LoginPages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardHome extends StatelessWidget {
  BoardHome({super.key});

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [BoardPage1(), BoardPage2(), BoardPage3(), SignInPage()],
          ),
          Positioned(
            top: 260,
            left: 27,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.white,//Color(0xFFFAFAFA),
                      dotColor: Colors.white38,
                      dotHeight: 10,
                      dotWidth: 10
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}