import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:webchallenger/home/home_page.dart';
import 'package:webchallenger/login/controller/login_controller.dart';
import 'package:webchallenger/login/widgets/login_form.dart';
import 'package:webchallenger/shared/widgets/error_showdialog_widget.dart';
import 'package:webchallenger/shared/widgets/loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = GetIt.I.get<LoginController>();

  @override
  void initState() {
    controller.emailController.clear();
    controller.passwordController.clear();
    controller.loginSuccess.addListener(() {
      setState(() {});
      if (controller.loginSuccess.value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      }
    });
    controller.errorMessage.addListener(() {
      setState(() {});
      if (controller.errorMessage.value.isNotEmpty) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorShowdialogWidget(errorTitle: controller.errorMessage.value);
            },
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/login_background.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue.withOpacity(0.5),
          ),
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Card(
                elevation: 50,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                color: Colors.white,
                child: SizedBox(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: Image.asset(
                            'assets/images/hand_image.png',
                            height: 25,
                          )),
                          const TextSpan(
                            text: ' Bem-vindo (a)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 29,
                              color: Color(0xFF00BFFF),
                            ),
                          ),
                        ])),
                        const SizedBox(height: 15),
                        LoginForm(controller: controller),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          LoadingWidget(valueListenable: controller.loading),
        ],
      ),
    ));
  }
}
