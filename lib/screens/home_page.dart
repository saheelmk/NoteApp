import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';
import 'package:note_app/data/datamodel/data.dart';
import 'package:note_app/data/service/note_model_service.dart';
import 'package:note_app/screens/add_task_page.dart';
import 'package:note_app/screens/task_show.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDB.instance.getAllNotes();
    });
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Minimalist Note  App",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        padding: EdgeInsets.all(20),
        height: 550,
        width: 370,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(offset: Offset(5.1, 4.5), blurRadius: 8.1)],
        ),
        child: ValueListenableBuilder(
          valueListenable: NoteDB.instance.notenotifierLisnter,
          builder: (context, List<NoteModel> newNotes, _) {
            if (newNotes.isEmpty) {
              return Center(child: Text("No notes found"));
            }

            return ListView.separated(
              itemBuilder: (BuildContext ctx, int index) {
                final note = NoteDB.instance.notenotifierLisnter.value[index];
                //element of todos
                return Container(
                  key: ValueKey(note.id),
                  padding: EdgeInsets.only(top: 18),
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(offset: Offset(2.0, 3.1), blurRadius: 5.0),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (ctx) => TaskPage(
                                title: note.title,
                                content: note.content,
                              ),
                        ),
                      );
                    },
                    subtitle: Text(
                      maxLines: 1,
                      note.content,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: SizedBox(width: 20),

                    title: Text(
                      maxLines: 1,
                      note.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (ctx) => AddTaskPage(
                                        type: ActionType.EditNote,
                                        id: note.id,
                                      ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit_note,
                              size: 25,
                              color: AppColors.dark,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              NoteDB.instance.deleteNote(note.id!);
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              size: 25,
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) => SizedBox(height: 20),
              itemCount: newNotes.length,
            );
          },
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (ctx) {
          return Container(
            height: 100,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (ctx) => AddTaskPage(type: ActionType.AddNote),
                        ),
                      );
                    },
                    icon: Icon(Icons.add, color: AppColors.dark, size: 23),
                    label: const Text(
                      "Add Task",
                      style: TextStyle(
                        color: AppColors.dark,

                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
