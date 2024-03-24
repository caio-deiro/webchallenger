import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:webchallenger/login/repository/login_repository.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository loginRepository;
  LoginController(this.loginRepository);

  final getIt = GetIt.instance;
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ValueNotifier<String> errorMessage = ValueNotifier('');
  ValueNotifier<bool> loginSuccess = ValueNotifier(false);
  ValueNotifier<bool> loading = ValueNotifier(false);

  Future<void> login({required String email, required String password}) async {
    loading.value = true;
    final response = loginRepository.login(email: email, password: password);
    loading.value = false;
    response.either((error) {
      errorMessage.value = error;
      notifyListeners();
    }, (success) {
      loginSuccess.value = success;
      notifyListeners();
    });
  }
}
