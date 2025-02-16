import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        GoRouter.of(context).go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png",
                width: 200, height: 200, fit: BoxFit.contain),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "OptimUz",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "San-Serif",
                      fontWeight:
                          FontWeight.bold), 
                ),
              ],
            ),
            Text(
              "Welcome To Our Online shopping app",
              style: TextStyle(
                fontSize: 16,
                fontFamily:
                    'san-serif', 
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
