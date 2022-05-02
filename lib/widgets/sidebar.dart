import 'package:flutter/material.dart';
import 'package:todo_app/navigation.dart';

import 'package:todo_app/widgets/app_text.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              'assets/images/sidebar logo.png',
              fit: BoxFit.fill,
            ),
          ),
          _ListTileWidget(
            icon: Icons.edit_note,
            title: 'Notes',
            color: Colors.green,
            function: () => Navigator.pop(context),
          ),
          _ListTileWidget(
            icon: Icons.timeline,
            title: 'Timeline',
            color: Colors.orange,
            function: () =>
                Navigator.pushNamed(context, MainNavigationRouteNames.timeline),
          ),
          _ListTileWidget(
            icon: Icons.checklist,
            title: 'Task Management',
            color: Colors.blue,
            function: () =>
                Navigator.pushNamed(context, MainNavigationRouteNames.tasks),
          ),
          _ListTileWidget(
            icon: Icons.alarm,
            title: 'Pomodoro',
            color: Colors.red,
            function: () =>
                Navigator.pushNamed(context, MainNavigationRouteNames.pomodoro),
          ),
          _ListTileWidget(
            icon: Icons.settings_outlined,
            title: 'Settings',
            color: Colors.blueGrey,
            function: () =>
                Navigator.pushNamed(context, MainNavigationRouteNames.settings),
          ),
          _ListTileWidget(
            icon: Icons.star_border,
            title: 'Rate us',
            color: Colors.orange,
            function: () {},
            isFalse: true,
          ),
        ],
      ),
    );
  }
}

class _ListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback function;
  final bool isFalse;
  final Color color;

  const _ListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.function,
    this.isFalse = false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !isFalse,
      leading: Icon(icon, color: isFalse ? color.withOpacity(.6) : color),
      title: AppText(
        size: 16,
        text: title,
        color: isFalse ? Colors.black.withOpacity(.6) : Colors.black,
      ),
      onTap: function,
    );
  }
}
