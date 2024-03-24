// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:webchallenger/register/repository/register_repository.dart';
import 'package:webchallenger/shared/model/user_model.dart';
import 'package:webchallenger/shared/service/dio_service.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final DioService dioService;
  RegisterRepositoryImpl(this.dioService);

  @override
  Future<Either<String, bool>> registerUser(
      {required String name, required String email, required String password}) async {
    try {
      final data = {
        'nome_completo': name,
        'email': email,
        'password': password,
      };
      final response = await dioService.post('/api/v1/users', data: data);
      if (response.statusCode == 201) {
        UserModel.fromJson(response.data);
        return const Right(true);
      } else {
        return Left(response.data['message']);
      }
    } catch (e) {
      print(e.toString());
      return const Left('Ocorreu um erro inesperado! Tente novamente.');
    }
  }
}
