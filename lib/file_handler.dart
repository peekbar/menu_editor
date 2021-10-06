import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileHandler {
  static Future<String> getFileAsString() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    String text = '';

    if (result != null) {
      File file = File(result.files.single.path!);
      text = await file.readAsString();
      print(text);
    }

    return text;
  }

  static void saveStringAs(String suggestedFileName, String content) async {
    String? outputFile =
        await FilePicker.platform.saveFile(dialogTitle: 'Save file as', fileName: suggestedFileName);

    if (outputFile != null) {
      File output = File(outputFile!);
      output.writeAsString(content);
    }
  }
}
