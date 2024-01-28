import 'package:my_app/model/Task.dart';
import 'package:my_app/repository/task.dart';
import 'package:my_app/viewmodel/observer.dart';
import 'package:my_app/viewmodel/viewmodel.dart';

class TaskViewModel extends EventViewModel {
  TaskRepository _repository;

  TaskViewModel(this._repository);

  void loadTasks() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadTasks().then((value) {
      notify(TasksLoadedEvent(tasks: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void createTask(String title, String description) {
    notify(LoadingEvent(isLoading: true));
    // ... code to create the task
    notify(TaskCreatedEvent(Task(0, title, description, false)));
    notify(LoadingEvent(isLoading: false));
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class TasksLoadedEvent extends ViewEvent {
  final List<Task> tasks;

  TasksLoadedEvent({required this.tasks}) : super("TasksLoadedEvent");
}

// should be emitted when
class TaskCreatedEvent extends ViewEvent {
  final Task task;

  TaskCreatedEvent(this.task) : super("TaskCreatedEvent");
}
