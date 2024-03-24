import 'package:flutter/material.dart';
import 'package:webchallenger/login/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'webChallenger',
      home: LoginPage(),
    );
  }
}
