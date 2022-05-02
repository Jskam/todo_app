import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: AppText(
          size: 20,
          text: 'Settings',
          fweight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: AppText(
                  size: 18,
                  text: 'Dark Theme',
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.toggle_off_outlined,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
