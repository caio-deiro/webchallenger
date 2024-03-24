import 'package:webchallenger/home/model/file_model.dart';

class AttachedFileModel {
  String id;
  String nomeUpload;
  String url;
  FileModel arquivo;
  String createdAt;
  String updatedAt;

  AttachedFileModel({
    required this.id,
    required this.nomeUpload,
    required this.url,
    required this.arquivo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttachedFileModel.fromJson(Map<String, dynamic> json) {
    return AttachedFileModel(
      id: json['id'],
      nomeUpload: json['nome_upload'],
      url: json['url'],
      arquivo: FileModel.fromMap(json['arquivo']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
