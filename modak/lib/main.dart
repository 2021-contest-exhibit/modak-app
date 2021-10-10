import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/CampingAPIBloc.dart';
import 'package:modak/bloc/ModakBloc.dart';
import 'package:modak/bloc/UserBloc.dart';
import 'package:modak/page/CapingDetailPage.dart';
import 'package:modak/page/CreateMatchingPage.dart';
import 'package:modak/page/DashBoardPage.dart';
import 'package:modak/page/LoginPage.dart';
import 'package:modak/page/MainPage.dart';
import 'package:modak/page/PaymentPage.dart';
import 'package:modak/page/SignUpPage.dart';
import 'package:modak/page/SplashPage.dart';
import 'package:modak/repository/APIRepository.dart';
import 'package:modak/repository/DBRepository.dart';
import 'package:modak/repository/FireStoreRepository.dart';
import 'package:modak/repository/UserRepository.dart';
import 'package:modak/rest/RestClient.dart';
import 'package:retrofit/dio.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  final dio = Dio();
  late final restClient;
  late final userRepository;

  MyApp() {
    restClient = RestClient(dio);
    userRepository = UserRepository(auth: auth);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserBloc(
                userRepository: userRepository,
                dbRepository: DBRepository())),
        BlocProvider(
            create: (_) => CampingAPIBloc(
                apiRepository:
                    APIRepository(dio: dio, restClient: restClient))),
        BlocProvider(
            create: (_) => ModakBloc(
                fireStoreRepository: FireStoreRepository(store: store), userRepository: userRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff87360C),
          fontFamily: 'BMDOHYEON_ttf',
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashPage(),
          '/dashboard': (context) => DashBoardPage(),
          '/login': (context) => LoginPage(),
          '/login/signup': (context) => SignUpPage(),
          '/': (context) => MainPage(),
          '/payment': (context) => PaymentPage(),
          '/camping_detail': (context) => CampingDetailPage(),
          '/create_matching': (context) => CreateMatchingPage(),
        },
      ),
    );
  }
}
