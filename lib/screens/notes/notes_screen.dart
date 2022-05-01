import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/notes/notes_model.dart';
import 'package:todo_app/widgets/app_text.dart';
import 'package:todo_app/widgets/sidebar.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NotesModel>();
    final notes = model.notes;
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: AppText(
          size: 20,
          text: 'Notes',
          fweight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: notes.isNotEmpty
          ? MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.symmetric(horizontal: 6),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                final themeColor = note.theme == 'work'
                    ? Colors.blue
                    : note.theme == 'study'
                        ? Colors.green
                        : Colors.orange[700];
                return InkWell(
                  onLongPress: () => model.deleteNote(note.key),
                  child: Container(
                    margin: index == 0 || index == 1
                        ? const EdgeInsets.only(
                            top: 10,
                          )
                        : index == notes.length || index == notes.length - 1
                            ? const EdgeInsets.only(
                                bottom: 10,
                              )
                            : null,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: AppText(
                            size: 15,
                            color: Colors.white,
                            text: note.title,
                            maxLines: 7,
                            overflow: true,
                          ),
                        ),
                        AppText(
                          size: 17,
                          color: Colors.white,
                          text: DateFormat.MMMMd().format(note.date),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: AppText(size: 18, text: 'Empty...'),
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Colors.white,
        onPressed: () => model.navToCreateNewNote(context),
        child: Icon(
          Icons.add,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}
