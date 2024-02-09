import 'package:flutter/material.dart';
import 'package:notesapp/models/notes.model.dart';

import '../models/user.model.dart';

abstract class BaseService {
  // SIGN IN WITH EMAIL AND PASSWORD
  Future<bool> signInWithEmailAndPassword(String email, String password);

  // CREATE USER WITH EMAIL AND PASSWORD
  Future createUserWithEmailAndPassword(String email, String password);

  // SIGN OUT
  Future<void> signOut();

  // SEND RESET EMAIL TO USER
  Future<void> sendResetEmailToUser(String email);

  // STORE USER DATA
  Future<void> storeUserData(UserModel user);

  // STORE Notes
  Future<void> storNotes(NotesModel notesModel);

  // Update Notes
  Future<void> updateNotes(String notesId, NotesModel notesModel);

  // Delete Notes
  Future<void> deleteNote(String notesId, BuildContext context);
}
