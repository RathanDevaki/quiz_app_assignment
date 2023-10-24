import 'package:flutter/material.dart';

import 'package:quiz_app_assignment/Provider/quiz_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Components/constants.dart';
import 'Components/router.dart';
import 'Domain/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyRouter myRouter = MyRouter();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => QuizProvider())],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Google Sans",
          colorScheme: myColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Quiz App - Niveus',
        routes: myRouter.routes,
        home: Home(),
      ),
    );
  }
}
