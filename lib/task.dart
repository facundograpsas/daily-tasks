class Task{

  final String text;
  final int id;
  int taskIndex;


  Task({this.id, this.text, this.taskIndex});

  Map<String, dynamic> toMap(){
      return {
        "id" : id,
        "text" : text,
        "taskIndex": taskIndex
      };
  }
}