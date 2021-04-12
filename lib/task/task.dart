class Task{

  final String text;
  final int? id;

  Task({this.id, required this.text});

  Map<String, dynamic> toMap(){
      return {
        "id" : id,
        "text" : text,
      };
  }
}