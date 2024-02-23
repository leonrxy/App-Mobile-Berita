import 'package:flutter/material.dart';

class SplashScreenKu extends StatefulWidget {
  @override
  _SplashScreenKuState createState() => _SplashScreenKuState();
}

class _SplashScreenKuState extends State<SplashScreenKu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}