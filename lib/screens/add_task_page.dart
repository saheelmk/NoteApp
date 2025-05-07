import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';
import 'package:note_app/data/datamodel/data.dart';
import 'package:note_app/data/service/note_model_service.dart';
import 'package:note_app/widgets/text_formfield_container.dart';

enum ActionType { AddNote, EditNote }

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key, required this.type, this.id});
  final ActionType type;
  final String? id;

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.EditNote) {
      if (id == null) {
        Navigator.of(context).pop();
      }

      final note = NoteDB.instance.getNoteByID(id!);
      if (note == null) {
        Navigator.of(context).pop();
      }

      titleController.text = note!.title;
      contentController.text = note.content;
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.light,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          type.name.toUpperCase(),
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          height: 370,
          width: 370,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(offset: Offset(5.1, 4.5), blurRadius: 8.1)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormfieldContainer(
                controller: titleController,
                labelText: titleController.text,
              ),
              SizedBox(height: 50),

              TextFormfieldContainer(
                controller: contentController,
                labelText: contentController.text,
              ),

              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 60,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.light,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        switch (type) {
                          case ActionType.AddNote:
                            saveNote();
                            break;
                          case ActionType.EditNote:
                            saveEditedNote();
                            break;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dark,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: AppColors.light,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // add new note
  Future<void> saveNote() async {
    final title = titleController.text;
    final content = contentController.text;

    final newModel = NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );

    final newNote = await NoteDB().createNote(newModel);
    if (newNote != null) {
      print('note saved');
      Navigator.of(_scaffoldKey.currentState!.context).pop();
    } else {
      print('error while saving');
    }
  }

  // /edited Note

  Future<void> saveEditedNote() async {
    final _title = titleController.text;
    final _content = contentController.text;

    final editedNote = NoteModel(title: _title, content: _content, id: id);
    final _note = await NoteDB.instance.updateNote(editedNote);
    if (_note == null) {
      print('unable to update');
    } else {
      Navigator.of(_scaffoldKey.currentState!.context).pop();
    }
  }
}
