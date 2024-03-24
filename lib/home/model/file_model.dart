// ignore_for_file: public_member_api_docs, sort_constructors_first

class FileModel {
  List<dynamic>? files;
  FileModel({
    required this.files,
  });

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(files: map['data']);
  }
}
