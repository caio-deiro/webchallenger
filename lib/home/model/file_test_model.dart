// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class FilePickedModel {
  String name;
  Uint8List bytes;
  FilePickedModel({
    required this.name,
    required this.bytes,
  });
}
