import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  static Future<String> getFileAsString() async {
    var result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: false, allowedExtensions: ['json']);
    var text = '';

    if (result != null) {
      var file = File(result.files.single.path!);
      text = await file.readAsString();
    }

    return text;
  }

  static Future<void> saveStringAs(String suggestedFileName, String content) async {
    var outputFile = await FilePicker.platform.saveFile(dialogTitle: 'Save file as', fileName: suggestedFileName);

    if (outputFile != null) {
      var output = File(outputFile);
      await output.writeAsString(content);
    }
    return;
  }

  static Future<String?> getDirectory(String dialog) async {
    var result = await FilePicker.platform.getDirectoryPath(dialogTitle: dialog);
    return result;
  }

  static Future<String?> createDirectory(String destination, String name) async {
    await Directory('$destination/$name').create();
    return Future.value('$destination/$name');
  }

  static Future<String> getApplicationLocationTemplateDirectory() async {
    final localDir = await getApplicationDocumentsDirectory();
    var templateDir = '${localDir.path}/templates';
    if (!Directory(templateDir).existsSync()) {
      Directory(templateDir).createSync();
    }
    return templateDir;
  }
}
