import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileController {
  Future<File?> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    return null; // Return null if no file was selected or the path is null.
  }
}
