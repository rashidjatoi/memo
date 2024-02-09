import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/data/base_service.dart';
import 'package:notesapp/models/notes.model.dart';
import 'package:notesapp/models/user.model.dart';
import 'package:notesapp/resources/constants/database_constants.dart';
import 'package:notesapp/utils/utils.dart';

class NetworkService extends BaseService {
  // CREATE USER WITH EMAIL & PASSWORD
  @override
  Future createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Utils.showToast(message: "Account Created");
    } on FirebaseAuthException catch (error) {
      Utils.showToast(message: error.message.toString());
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Utils.showToast(message: "Logged in");
      return auth.currentUser != null;
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: e.message.toString());
      return false;
    }
  }

  // SIGN OUT
  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (error) {
      rethrow;
    }
  }

  // STORE USER DATA
  @override
  Future<void> storeUserData(UserModel user) async {
    try {
      await databaseReference
          .child(auth.currentUser!.uid.toString())
          .set(user.toJson());
    } catch (error) {
      rethrow;
    }
  }

  // SEND RESET EMAIL TO USER
  @override
  Future<void> sendResetEmailToUser(String email) {
    return auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> storNotes(NotesModel notesModel) async {
    final user = FirebaseAuth.instance.currentUser;
    final notesId = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      usersDatabase
          .child(user!.uid)
          .child(notesId.toString())
          .set(notesModel.toJson());
      Utils.showToast(message: "Notes Saved");
    } on FirebaseAuthException catch (error) {
      Utils.showToast(message: error.message.toString());
    }
  }

  @override
  Future<void> updateNotes(String notesId, NotesModel notesModel) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      await usersDatabase
          .child(user!.uid)
          .child(notesId.toString())
          .update(notesModel.toJson());
      Utils.showToast(message: "Notes Updated");
    } on FirebaseAuthException catch (error) {
      Utils.showToast(message: error.message.toString());
    }
  }

  @override
  Future<void> deleteNote(String notesId, BuildContext context) async {
    try {
      await usersDatabase.child(user!.uid).child(notesId.toString()).remove();
      Utils.showToast(message: "Notes Deleted");
    } on FirebaseAuthException catch (error) {
      Utils.showToast(message: error.message.toString());
    }
  }
}
