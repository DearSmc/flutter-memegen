import 'package:firebase_auth/firebase_auth.dart';

class MyAuthen {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    // .then((value) => print(value));
  }

  // null safety =>ตรงที่อาจจะเป็น null อย่างข้างล่างคือ อาจจะออกเป็น type นี้หรือ null บอกว่าไม่ nullแน่ๆ
  static User? getUser() {
    return auth.currentUser;
  }

  static Future<void> signOut() async {
    auth.signOut();
  }

  //userCredential return form create or signin
  static Future<User> register(
      String email, String password, String displayName) async {
    User user;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    user = userCredential.user!;
    await user.updateDisplayName(displayName);
    user = auth.currentUser!;
    return user;
  }
}
