import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/UserBloc.dart';
import 'package:modak/component/BottomNavigationWidget.dart';
import 'package:modak/page/CampingSearchPage.dart';
import 'package:modak/page/DashBoardPage.dart';
import 'package:modak/page/MapPage.dart';
import 'package:modak/page/MatchingPage.dart';
import 'package:modak/page/SettingPage.dart';
import 'package:modak/repository/DBRepository.dart';
import 'package:modak/repository/UserRepository.dart';

class MainPage extends StatefulWidget {
  final PageController pageController = PageController(initialPage: 0);

  @override
  State createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: widget.pageController,
            children: [
              DashBoardPage(pageController: widget.pageController,),
              MatchingPage(),
              CampingSearchPage(),
              SettingPage(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: BottomNavigationWidget(
              pageController: widget.pageController,
            ),
          )
        ],
      ),
    );
  }
}
