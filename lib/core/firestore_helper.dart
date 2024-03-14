// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c10_online_sun/model/user.dart';

import '../model/task.dart';

class FirestoreHelper{

  static CollectionReference<User> getUserCollection(){
    var reference = FirebaseFirestore.instance.collection("Users").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String , dynamic>? doc = snapshot.data();
        return User.fromFirestore(doc);
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
    return reference;

  }
  static Future<void> AddNewUser(User user)async{
    var userCollection = getUserCollection();
    var docReference = userCollection.doc(user.id);
    await docReference.set(user);
  }
  static Future<User?> getUser(String userId)async{
    var userCollection = getUserCollection();
    var docReference = userCollection.doc(userId);
    var snapshot = await docReference.get();
    var user = snapshot.data();
    return user;
  }

  static CollectionReference<Task> getTasksCollection(String userId){
    var collectionReference = getUserCollection().doc(userId).collection("tasks").withConverter(
        fromFirestore: (snapshot , options){
          return Task.fromFirestore(snapshot.data());
        },
        toFirestore: (task , options){
          return task.toFirestore();
        }
    );
    return collectionReference;
  }

  static Future<void> AddNewTask({required String userId, required Task task})async{
    var collectionReference =  getTasksCollection(userId);
    var doc = collectionReference.doc();
    task.id = doc.id;
    await doc.set(task);
  }

  static Future<void> updateTaskToTrue({required String userId, required Task task}) async{
    var collectionReference =  getTasksCollection(userId);
    await collectionReference.doc(task.id).update({"isDone": true});
  }

  static Future<void> updateTaskDetails({required String userId, required Task task, String? title, String? discription, Timestamp? date }) async{
    var collectionReference =  getTasksCollection(userId);
    await collectionReference.doc(task.id).update(
        {
          'title': title ?? task.title,
          'description': discription ?? task.description,
          'date': date ?? task.date,
          'id': task.id,
          'isDone' : task.isDone,
        }
    );
  }

  static Future<List<Task>> GetAllTasks(String userId , Timestamp date)async{
    var collectionReference =  getTasksCollection(userId).where("date",isEqualTo: date);
    var querySnapshot = await collectionReference.get();
    var listQueryDocs = querySnapshot.docs;
    List<Task> tasksList = listQueryDocs.map((snapshot) => snapshot.data()).toList();
    return tasksList;
  }
}