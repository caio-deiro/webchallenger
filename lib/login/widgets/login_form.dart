// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import 'package:webchallenger/login/controller/login_controller.dart';
import 'package:webchallenger/register/register_page.dart';

class LoginForm extends StatelessWidget {
  final LoginController controller;
  const LoginForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.emailController,
              validator: Validatorless.multiple([
                Validatorless.required('Campo Obrigatório'),
                Validatorless.email('Email errado'),
              ]),
              decoration: const InputDecoration(
                label: Text('Email'),
                hintText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              validator: Validatorless.required('Campo obrigatório'),
              decoration: const InputDecoration(
                  label: Text('Senha'),
                  hintText: 'Senha',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15)),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              )),
              child: const Text('Criar Conta'),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF1E90FF),
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(0, 56)),
                    onPressed: () async {
                      if (controller.loginFormKey.currentState?.validate() ?? false) {
                        await controller.login(
                          email: controller.emailController.text.trim(),
                          password: controller.passwordController.text.trim(),
                        );
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
