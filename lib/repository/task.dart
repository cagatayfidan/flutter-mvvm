import 'package:my_app/model/task.dart';
import 'package:my_app/repository/database.dart';

class TaskRepository {
  IndexedDB _indexedDB = IndexedDB();

  final List<Task> _taskList = [];

  Future<Task> addTask(String title) async {
    Task task = Task(_taskList.length, title, false);
    await _indexedDB.writeToDatabase(task.toJson());
    _taskList.add(task);
    return task;
  }

  Future<void> removeTask(Task task) async {
    await _indexedDB.deleteFromDatabase(task.id);
    _taskList.remove(task);
  }

  Future<List<Task>> loadTasks() async {
    List<Task> records = await _indexedDB.readFromDatabase();
    _taskList.addAll(records);
    return _taskList;
  }
}
