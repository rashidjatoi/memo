import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/data/network_service.dart';
import 'package:notesapp/models/notes.model.dart';
import 'package:notesapp/utils/utils.dart';

class NotesViewModel extends ChangeNotifier {
  final NetworkService networkService = NetworkService();

  Future<void> storeNotes(NotesModel notesModel) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final notesId = DateTime.now().microsecondsSinceEpoch.toString();
      if (user == null) {
        return;
      }
      notifyListeners();
      notesModel.notesId = notesId;
      await networkService.storNotes(notesModel);
      // await usersDatabase
      //     .child(user.uid)
      //     .child(notesId.toString())
      //     .set(notesModel.toJson());
    } catch (error) {
      Utils.showToast(message: 'Error storing notes: $error');
    }
  }

  // UPDATE NOTE
  Future<void> updateNotes(String notesId, NotesModel notesModel) async {
    try {
      await networkService.updateNotes(notesId, notesModel);
    } catch (error) {
      Utils.showToast(message: 'Error storing notes: $error');
    }
  }

  // DELETE NOTE
  Future<void> deleteNotes(String notesId, BuildContext context) async {
    try {
      await networkService.deleteNote(notesId, context);
    } catch (error) {
      Utils.showToast(message: 'Error storing notes: $error');
    }
  }
}
