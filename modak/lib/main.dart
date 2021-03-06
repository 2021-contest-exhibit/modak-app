import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:modak/bloc/CampingAPIBloc.dart';
import 'package:modak/bloc/ModakBloc.dart';
import 'package:modak/bloc/UserBloc.dart';
import 'package:modak/page/CampingSearchResultPage.dart';
import 'package:modak/page/CampingDetailPage.dart';
import 'package:modak/page/ChattingPage.dart';
import 'package:modak/page/CovidRegisterPage.dart';
import 'package:modak/page/CreateMatchingPage.dart';
import 'package:modak/page/DashBoardPage.dart';
import 'package:modak/page/GoodsPage.dart';
import 'package:modak/page/LoginPage.dart';
import 'package:modak/page/MainPage.dart';
import 'package:modak/page/Payment.dart';
import 'package:modak/page/PaymentPage.dart';
import 'package:modak/page/SelectCampingPage.dart';
import 'package:modak/page/SettingDetailPage.dart';
import 'package:modak/page/SignUpPage.dart';
import 'package:modak/page/SplashPage.dart';
import 'package:modak/page/UserDetailPage.dart';
import 'package:modak/repository/APIRepository.dart';
import 'package:modak/repository/DBRepository.dart';
import 'package:modak/repository/FireStoreRepository.dart';
import 'package:modak/repository/FirebaseStorageRepository.dart';
import 'package:modak/repository/UserRepository.dart';
import 'package:modak/rest/RestClient.dart';

final logger = Logger();

main() async {
  // initializeJsonMapper();
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
  late final apiRepository;
  late final fireStoreRepository;

  MyApp() {
    dio.options.headers["Content-Type"] = "application/json";
    restClient = RestClient(dio);
    userRepository = UserRepository(auth: auth);
    apiRepository = APIRepository(dio: dio, restClient: restClient);
    fireStoreRepository = FireStoreRepository(store: store);
    store.collection('chattings').snapshots(includeMetadataChanges: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserBloc(
                userRepository: userRepository,
                dbRepository: DBRepository(),
                fireStoreRepository: fireStoreRepository,
                apiRepository: apiRepository)),
        BlocProvider(
            create: (_) => CampingAPIBloc(
                apiRepository: apiRepository, userRepository: userRepository)),
        BlocProvider(
            create: (_) => ModakBloc(
                  fireStoreRepository: fireStoreRepository,
                  userRepository: userRepository,
                  apiRepository: apiRepository,
                  firebaseStorageRepository: FirebaseStorageRepository(
                      firebaseStorage: FirebaseStorage.instance),
                )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff000000),
        ),
        initialRoute: '/splash',
        routes: {
          // '/covid_register': (context) => CovidRegisterPage(),
          '/splash': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/login/signup': (context) => SignUpPage(),
          '/': (context) => MainPage(),
          '/payment': (context) => PaymentPage(),
          '/camping_detail': (context) => CampingDetailPage(),
          '/create_matching': (context) => CreateMatchingPage(),
          '/goods': (context) => GoodsPage(),
          '/camping_search_result': (context) => CampingSearchResultPage(
              argument: ModalRoute.of(context)!.settings.arguments as Map),
          '/chatting': (context) => ChattingPage(),
          '/import': (context) => Payment(),
          '/select_camping': (context) => SelectCampingPage(),
          '/setting_detail': (context) => SettingDetailPage(),
          '/user_detail': (context) => UserDetailPage(),
        },
      ),
    );
  }
}
