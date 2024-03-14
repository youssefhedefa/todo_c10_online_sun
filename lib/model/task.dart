import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String? id;
  String? title;
  String? description;
  bool? isDone;
  Timestamp? date;
  Task({this.id , required this.date , required this.title , required this.description, this.isDone = false});

  Task.fromFirestore(Map<String , dynamic>? data){
    id = data?["id"];
    title = data?['title'];
    description = data?['description'];
    isDone = data?['isDone'];
    date = data?['date'];
  }

  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "isDone":isDone,
      "date":date
    };
  }
}