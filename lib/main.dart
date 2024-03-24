import 'package:flutter/material.dart';
import 'package:webchallenger/app_widget.dart';
import 'package:webchallenger/shared/get_it_register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetItInstancies();
  runApp(const AppWidget());
}
