import 'dart:io';

import 'package:deadliney/db/database.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile() async {
  var directory = await getApplicationDocumentsDirectory();
  var path = directory.path;
  var file = File('$path/deadliney.csv');
  return file;
}

Future<void> writeToFile(File file, List<Task> content) async {
  for (int i = 0; i < content.length; i++) {
    if (i == 0) {
      await file.writeAsString(_taskToCSVFormat(content[i]));
    } else {
      await file.writeAsString('\n${_taskToCSVFormat(content[i])}', mode: FileMode.append);

    }
  }
}

String _taskToCSVFormat(Task task) {
  return '${task.name}, ${task.dueDate!.toIso8601String()}, ${task.timestamp!.toIso8601String()}, ${task.completed}';
}
