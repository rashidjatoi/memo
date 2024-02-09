import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notesapp/models/notes.model.dart';
import 'package:notesapp/resources/components/custom_button.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:notesapp/view_model/notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  final NotesModel notesModel;
  const NotesView({super.key, required this.notesModel});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  // TITLE AND DESCRIPTION CONTROLLERS
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.notesModel.title);
    descController = TextEditingController(text: widget.notesModel.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        elevation: 0.9,
        centerTitle: true,
        actions: [
          // DELETE NOTE
          Consumer<NotesViewModel>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () async {
                  await value
                      .deleteNotes(
                        widget.notesModel.notesId.toString(),
                        context,
                      )
                      .then((value) => Navigator.of(context).pop());
                },
                icon: const Icon(
                  IconlyLight.delete,
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // SIZEDBOX
            const SizedBox(height: 10),

            // TITLE
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            // SIZEDBOX
            const SizedBox(height: 20),

            // DESCRIPTION
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

            // SIZEDBOX
            const SizedBox(height: 20),

            // UPDATE BUTTON

            Consumer<NotesViewModel>(
              builder: (context, value, child) {
                return CustomButton(
                  btnText: 'Update',
                  btnMargin: 0,
                  ontap: () {
                    String title = titleController.text.trim().toString();
                    String desc = descController.text.trim().toString();
                    if (title == "" || desc == "") {
                      return Utils.flushBarErrorMessage(
                        'All fields are required',
                        context,
                      );
                    }

                    NotesModel notesModel = NotesModel(
                        title: title,
                        description: desc,
                        notesId: widget.notesModel.notesId);
                    value.updateNotes(
                      widget.notesModel.notesId.toString(),
                      notesModel,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
