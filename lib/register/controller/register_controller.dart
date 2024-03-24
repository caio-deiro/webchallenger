import 'package:flutter/material.dart';
import 'package:webchallenger/register/repository/register_repository.dart';

class RegisterController extends ChangeNotifier {
  final RegisterRepository registerRepository;
  RegisterController(this.registerRepository);

  final registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ValueNotifier loading = ValueNotifier(false);

  String errorMessage = '';
  bool registerSuccess = false;

  Future<void> registerUser({required String name, required String email, required String password}) async {
    loading.value = true;
    final response = await registerRepository.registerUser(name: name, email: email, password: password);
    loading.value = false;
    response.fold(
      (error) => errorMessage = error,
      (success) => registerSuccess = success,
    );
  }
}
