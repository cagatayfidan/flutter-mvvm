class Task {
  int id;
  String title;
  bool done;

  Task(this.id, this.title, this.done);

  //TODO write a base class for this
  factory Task.fromJson(dynamic json) {
    return Task(
      json['id'],
      json['title'],
      json['done'],
    );
  }

  Map toJson() => {'id': this.id, 'title': this.title, 'done': this.done};

  @override
  String toString() {
    return '{ ${this.id}, ${this.title} ${this.done} }';
  }

}
