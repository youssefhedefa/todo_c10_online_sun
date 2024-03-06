import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c10_online_sun/model/user.dart';

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

}