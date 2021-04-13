class Task{

  final String text;
  final int? id;
  int done;

  Task({this.id, required this.text, this.done=0});

  Map<String, dynamic> toMap(){
      return {
        "id" : id,
        "text" : text,
        "done": done
      };
  }
}