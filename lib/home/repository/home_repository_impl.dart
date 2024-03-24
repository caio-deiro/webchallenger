import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:webchallenger/home/model/attach_file_model.dart';
import 'package:webchallenger/home/model/file_test_model.dart';
import 'package:webchallenger/home/repository/home_repository.dart';
import 'package:webchallenger/shared/service/dio_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DioService dioService;

  HomeRepositoryImpl(this.dioService);
  @override
  Future<Either<String, bool>> sendFiles({required List<FilePickedModel> filePathList}) async {
    try {
      FormData formData = FormData.fromMap({
        'arquivo': filePathList.map((e) => MultipartFile.fromBytes(e.bytes, filename: e.name)).toList(),
      });

      final response = await dioService.post('/api/v1/uploads', data: formData);
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(response.data['message']);
      }
    } catch (e) {
      print(e.toString());
      return const Left('Ocorreu um erro inesperado! Tente novamente.');
    }
  }

  @override
  Future<Either<String, List<AttachedFileModel>>> getFiles() async {
    try {
      final response = await dioService.get('/api/v1/uploads/', queryParameters: {
        'page': 1,
        'limit': 10,
      });
      if (response.statusCode == 200) {
        final result = (response.data['data'] as List).map((e) => AttachedFileModel.fromJson(e)).toList();
        return Right(result);
      } else {
        return Left(response.data['message']);
      }
    } catch (e) {
      print(e.toString());
      return const Left('Ocorreu um erro inesperado! Tente novamente.');
    }
  }
}
