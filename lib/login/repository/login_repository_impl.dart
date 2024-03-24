import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:webchallenger/login/repository/login_repository.dart';
import 'package:webchallenger/shared/service/dio_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  DioService dioService;
  LoginRepositoryImpl(this.dioService);

  @override
  Future<Either<String, bool>> login({required String email, required String password}) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      final response = await dioService.post('/login', data: data);
      if (response.statusCode == 200) {
        dioService.token = response.data['access_token'];
        dioService.userId = response.data['userId'];
        return const Right(true);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      print(e.error);
      return const Left('Ocorreu um erro inesperado! Tente novamente.');
    }
  }
}
