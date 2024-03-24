import 'package:either_dart/either.dart';
import 'package:webchallenger/home/model/attach_file_model.dart';
import 'package:webchallenger/home/model/file_test_model.dart';

abstract class HomeRepository {
  Future<Either<String, bool>> sendFiles({required List<FilePickedModel> filePathList});

  Future<Either<String, List<AttachedFileModel>>> getFiles();
}
