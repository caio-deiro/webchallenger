import 'package:get_it/get_it.dart';
import 'package:webchallenger/home/controller/home_controller.dart';
import 'package:webchallenger/home/repository/home_repository.dart';
import 'package:webchallenger/home/repository/home_repository_impl.dart';
import 'package:webchallenger/login/controller/login_controller.dart';
import 'package:webchallenger/login/repository/login_repository.dart';
import 'package:webchallenger/login/repository/login_repository_impl.dart';
import 'package:webchallenger/register/controller/register_controller.dart';
import 'package:webchallenger/register/repository/register_repository.dart';
import 'package:webchallenger/register/repository/register_repository_impl.dart';
import 'package:webchallenger/shared/service/dio_service.dart';

void setupGetItInstancies() {
  // Dio
  GetIt.I.registerLazySingleton<DioService>(() => DioService());

  // Repositories
  GetIt.I.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(GetIt.I<DioService>()));
  GetIt.I.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(GetIt.I<DioService>()));
  GetIt.I.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(GetIt.I<DioService>()));

  // Controllers
  GetIt.I.registerLazySingleton<LoginController>(() => LoginController(GetIt.I<LoginRepository>()));
  GetIt.I.registerLazySingleton<RegisterController>(() => RegisterController(GetIt.I<RegisterRepository>()));
  GetIt.I.registerLazySingleton<HomeController>(() => HomeController(GetIt.I<HomeRepository>()));
}
