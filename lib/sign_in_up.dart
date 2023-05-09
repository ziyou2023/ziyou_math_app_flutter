import 'package:flutter/material.dart';

class SignInUp extends StatefulWidget {
  const SignInUp({Key? key}) : super(key: key);

  @override
  State<SignInUp> createState() => _SignInUp();

}

class _SignInUp extends State<SignInUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sign In & Sign Up', style: Theme.of(context).primaryTextTheme.titleLarge, ),
      ),
    );
  }
}