import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/intro_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => IntroPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
      path: '/add',
      builder: (context, state) {
        final addNewProductPage = state.extra as AddNewProductPage?;
        return addNewProductPage ??
            AddNewProductPage(); 
      }),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
], );