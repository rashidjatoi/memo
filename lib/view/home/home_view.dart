import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notesapp/models/notes.model.dart';
import 'package:notesapp/resources/constants/database_constants.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:notesapp/view/notes_view/notes_view.dart';
import 'package:notesapp/view_model/auth_view_model.dart';
import 'package:notesapp/view_model/notes_view_model.dart';
import 'package:provider/provider.dart';

import '../auth/login/signin_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ADD CONTENT NOTES
    void showBottmSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: descController,
                      minLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),
                    Consumer<NotesViewModel>(
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            String title =
                                titleController.text.trim().toString();
                            String desc = descController.text.trim().toString();
                            if (title == "" || desc == "") {
                              Utils.showToast(
                                  message: 'All fields are required');
                            }
                            NotesModel notesModel = NotesModel(
                              title: title,
                              description: desc,
                            );
                            await value.storeNotes(notesModel).then((value) {
                              titleController.clear();
                              descController.clear();
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Save'),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        centerTitle: true,
        elevation: 0.9,
        actions: [
          // LOGOUT USER
          Consumer<AuthViewModel>(
            builder: (context, value, child) => IconButton(
              onPressed: () {
                value.logoutUser(() {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const SignInView();
                    },
                  ));
                });
              },
              icon: const Icon(IconlyLight.logout),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream:
                usersDatabase.child(auth.currentUser!.uid.toString()).onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              if (snapshot.hasData && snapshot.data != null) {
                Map<dynamic, dynamic>? data =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                if (data != null && data.isNotEmpty) {
                  return Column(
                    children: data.entries.map((entry) {
                      var record = entry.value;

                      var title = record['title'];
                      var notesId = record['notesId'];
                      var description = record['description'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade800),
                          ),
                          child: ListTile(
                            title: Text(title.toString()),
                            subtitle: Text(description.toString()),
                            onTap: () {
                              NotesModel notesModel = NotesModel(
                                title: title,
                                description: description,
                                notesId: notesId,
                              );
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return NotesView(notesModel: notesModel);
                                },
                              ));
                            },
                            trailing: const Icon(IconlyLight.arrow_right),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              } else {
                return const Center(child: Text('Add Your Notes'));
              }
            },
          ))
        ],
      ),

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottmSheet(context);
        },
        child: const Icon(IconlyBroken.edit),
      ),
    );
  }
}
