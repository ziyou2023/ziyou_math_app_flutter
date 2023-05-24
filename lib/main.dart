import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ziyou_math_app_flutter/HomePage.dart';

import 'sign_in_up.dart';
import 'view_homework.dart';
import 'competition.dart';
import 'create_content.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: "/create_content",
        builder: (context, state) => const CreatePage(),
      ),
      GoRoute(
        path: "/sign_in_up",
        builder: (context, state) => const SignInUp(),
      ),
      GoRoute(
        path: "/view_homework",
        builder: (context, state) => const ViewHomework(),
      ),
      GoRoute(
        path: "/competition",
        builder: (context, state) => const Competition(),
      ),
    ],
  );

  Widget router(BuildContext context) => MaterialApp.router(
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.deepPurple),
        primaryTextTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 20.0, fontFamily: 'Hind', color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 26),
                fixedSize: const Size(240, 60),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10))
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 2.0),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}


