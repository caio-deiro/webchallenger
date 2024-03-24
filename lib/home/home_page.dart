import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:webchallenger/home/controller/home_controller.dart';
import 'package:webchallenger/home/widgets/pages/home_normal_page.dart';
import 'package:webchallenger/home/widgets/pages/home_resized_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = GetIt.I.get<HomeController>();

  @override
  void initState() {
    controller.getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return HomeResizedPage(controller: controller);
        } else {
          return HomeNormalPage(controller: controller);
        }
      },
    ));
  }
}
