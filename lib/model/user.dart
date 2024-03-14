class User{
  String? id;
  String? fullName;
  int? age;
  String? email;
  User({this.id , this.email , this.fullName , this.age});

  User.fromFirestore(Map<String , dynamic>? data){
    id = data?['id'];
    fullName = data?['fullname'];
    age = data?['age'];
    email = data?['email'];
  }

  Map<String , dynamic> toFirestore(){
    return {
      "id":id,
      "fullname":fullName,
      "age":age,
      "email":email
    };
  }
}