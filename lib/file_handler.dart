import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileHandler {
  static Future<String> getFileAsString() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: false, allowedExtensions: ['json']);
    String text = '';

    if (result != null) {
      File file = File(result.files.single.path!);
      text = await file.readAsString();
    }

    return text;
  }

  static Future<void> saveStringAs(String suggestedFileName, String content) async {
    String? outputFile = await FilePicker.platform.saveFile(dialogTitle: 'Save file as', fileName: suggestedFileName);

    if (outputFile != null) {
      File output = File(outputFile);
      await output.writeAsString(content);
    }
    return;
  }

  static Future<String?> getDirectory(String dialog) async {
    String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: dialog);
    return result;
  }

  static Future<String?> createDirectory(String destination, String name) async { 

    await Directory(destination+'/'+name).create();
    return Future.value(destination+'/'+name);
  }
}
