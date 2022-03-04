import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  String menu_title;
  Icon menu_icon;
  Function handler;
  MenuItem(this.menu_title, this.menu_icon, this.handler);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.menu_title),
      leading: widget.menu_icon,
      trailing: Icon(Icons.keyboard_return),
      onTap: () {
        this.widget.handler(context);
      },
    );
  }
}
