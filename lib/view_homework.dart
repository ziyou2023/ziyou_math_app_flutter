import 'package:flutter/material.dart';

class ViewHomework extends StatefulWidget {
  const ViewHomework({Key? key}) : super(key: key);

  @override
  State<ViewHomework> createState() => _ViewHomework();

}

class _ViewHomework extends State<ViewHomework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('View Homework', style: Theme.of(context).primaryTextTheme.titleLarge, ),
      ),
    );
  }
}