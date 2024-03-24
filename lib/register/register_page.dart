import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:validatorless/validatorless.dart';
import 'package:webchallenger/login/login_page.dart';
import 'package:webchallenger/register/controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = GetIt.I.get<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://i0.wp.com/www.unibrasil.com.br/wp-content/uploads/2020/11/shutterstock_524351842_red.jpg?fit=1204%2C768&ssl=1',
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
                        Form(
                            key: controller.registerFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.nameController,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Campo Obrigatório'),
                                    Validatorless.min(2, 'Insira ao menos 2 caracteres')
                                  ]),
                                  decoration: const InputDecoration(
                                    label: Text('Nome completo'),
                                    hintText: 'Email',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                                  ),
                                ),
                                const SizedBox(height: 20),
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
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Campo Obrigatório'),
                                    Validatorless.min(6, 'Tamanho mínimo de 6 caracteres')
                                  ]),
                                  decoration: const InputDecoration(
                                      label: Text('Senha'),
                                      hintText: 'Senha',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15)),
                                ),
                              ],
                            )),
                        const SizedBox(height: 30),
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
                                  if (controller.registerFormKey.currentState?.validate() ?? false) {
                                    await controller.registerUser(
                                      name: controller.nameController.text,
                                      email: controller.emailController.text.trim(),
                                      password: controller.passwordController.text.trim(),
                                    );
                                    if (controller.registerSuccess) {
                                      if (context.mounted) Navigator.pop(context);
                                      if (mounted) {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text('Cadastro criado com sucesso!'),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                          builder: (context) => const LoginPage(),
                                                        ));
                                                      },
                                                      child: const Text('Fechar'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        Future.delayed(const Duration(seconds: 2))
                                            .then((value) => Navigator.pop(context));
                                      }
                                    } else {
                                      if (context.mounted) {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(controller.errorMessage),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Fechar'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  }
                                },
                                child: const Text('Registrar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.loading,
            builder: (context, value, _) {
              return Visibility(
                  visible: value,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ));
            },
          )
        ],
      ),
    ));
  }
}
