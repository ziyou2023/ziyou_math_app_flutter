import 'package:flutter/material.dart';

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);

  @override
  State<Competition> createState() => _Competition();

}

class _Competition extends State<Competition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Competition', style: Theme.of(context).primaryTextTheme.titleLarge, ),
      ),
    );
  }
}