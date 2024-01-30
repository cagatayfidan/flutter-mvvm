import 'package:my_app/model/task.dart';
import 'package:my_app/repository/task.dart';
import 'package:my_app/viewmodel/observer.dart';
import 'package:my_app/viewmodel/viewmodel.dart';

class TaskViewModel extends EventViewModel {
  TaskRepository _repository;

  TaskViewModel(this._repository);

  void loadTasks() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadTasks().then((value) {
      notify(TasksLoadedEvent(
          tasks: value
              .map((task) => Task(task.id, task.title, task.done))
              .toList()));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void createTask(String title) {
    notify(LoadingEvent(isLoading: true));
    _repository.addTask(title).then((value) => notify(TaskCreatedEvent(value)));
    notify(LoadingEvent(isLoading: false));
  }

  void deleteTask(Task task) {
    notify(LoadingEvent(isLoading: true));
    _repository.removeTask(task).then((value) => notify(TaskDeletedEvent()));
    notify(LoadingEvent(isLoading: false));
  }

  // void updateTask(Task task) {
  //   notify(LoadingEvent(isLoading: true));
  //   _repository.updateTask(task).then((value) => notify(TaskDeletedEvent()));
  //   notify(LoadingEvent(isLoading: false));
  // }
  
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

class TaskDeletedEvent extends ViewEvent {
  TaskDeletedEvent() : super("TaskDeletedEvent");
}
