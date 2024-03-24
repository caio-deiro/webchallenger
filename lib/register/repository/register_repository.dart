import 'package:either_dart/either.dart';

abstract class RegisterRepository {
  Future<Either<String, bool>> registerUser({required String name, required String email, required String password});
}
