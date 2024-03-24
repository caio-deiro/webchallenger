import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:webchallenger/home/model/attach_file_model.dart';
import 'package:webchallenger/home/model/file_test_model.dart';
import 'package:webchallenger/home/repository/home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository repository;
  HomeController(this.repository) : super();

  ValueNotifier<List<FilePickedModel>> attachFiles = ValueNotifier([]);
  ValueNotifier<List<AttachedFileModel>> attachFilesHistoric = ValueNotifier([]);

  ValueNotifier<String> errorMessage = ValueNotifier('');
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> sendFileSuccess = ValueNotifier(false);

  Future<void> attachFile() async {
    FilePickerResult? filePicker = await FilePicker.platform.pickFiles();

    if (filePicker != null) {
      List<FilePickedModel> newList = [...attachFiles.value];
      Uint8List bytes = filePicker.files.single.bytes!;
      String name = filePicker.files.single.name;
      newList.add(FilePickedModel(bytes: bytes, name: name));
      attachFiles.value = newList;
    }
  }

  Future<void> sendFiles() async {
    loading.value = true;
    final result = await repository.sendFiles(filePathList: attachFiles.value);
    loading.value = false;
    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (success) {
        sendFileSuccess.value = success;
      },
    );
  }

  Future<void> getFiles() async {
    loading.value = true;
    final result = await repository.getFiles();
    loading.value = false;

    result.fold((error) => errorMessage.value = error, (attachList) {
      attachFilesHistoric.value = attachList;
    });
  }

  void removeItem(FilePickedModel file) {
    List<FilePickedModel> newList = [...attachFiles.value];
    newList.remove(file);
    attachFiles.value = newList;
    return;
  }
}
