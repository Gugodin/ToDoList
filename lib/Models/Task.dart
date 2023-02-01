class Task {
  Task(
      {this.id,
      this.title,
      this.isCompleted,
      this.dueDate,
      this.comments,
      this.description,
      this.tags});

  int? id;
  String? title;
  int? isCompleted;
  String? dueDate;
  String? comments;
  String? description;
  String? tags;

  @override
  String toString() {
    return 'id: $id,titulo: $title';
  }
}
