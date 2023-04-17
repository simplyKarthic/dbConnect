import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference usersRef = FirebaseFirestore.instance.collection('user');

Future<String> signInWithEmail(String email, String password) async {
  final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  final User user = userCredential.user!;
  return user.uid;
}

Future<void> addUser(String userUid, String name, String email) {
  return usersRef.doc(userUid).set({
    'name': name,
    'email': email,
  });
}

Future<void> getUsers(String userUid) async {
  final DocumentSnapshot querySnapshot = await usersRef.doc(userUid).get();
  print("get Users from firebase");
  if (querySnapshot.exists) {
    print(querySnapshot.data());
  } else {
    print('Document does not exist');
  }
}

Future<void> updateUser(String documentId, String name, String email) {
  return usersRef.doc(documentId).update({
    'name': name,
    'email': email,
  });
}

Future<void> deleteUser(String documentId) {
  return usersRef.doc(documentId).delete();
}


