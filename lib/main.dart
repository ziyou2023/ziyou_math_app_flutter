import 'package:flutter/material.dart';

import 'sign_in_up.dart';
import 'view_homework.dart';
import 'competition.dart';
import 'mongodb.dart';
import 'create_content.dart';

void main() async{
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const MyHomePage(),
        '/create_content': (context) => const CreatePage(),
        '/sign_in_up': (context) => const SignInUp(),
        '/view_homework': (context) => const ViewHomework(),
        '/competition': (context) => const Competition(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.deepPurple),
        primaryTextTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 20.0, fontFamily: 'Hind', color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 26),
                fixedSize: const Size(240, 60),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10))
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 2.0),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

    dynamic showDataListViewBuilder(BuildContext context, AsyncSnapshot snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Text("Error: ${snapshot.error}");
        }
        else {
          if (snapshot.data == []) {
            return const Text("Empty!!");
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${index+1}. Title: ${snapshot.data[index]["title"]}", style: Theme.of(context).primaryTextTheme.bodyLarge),
                  subtitle: Text("  Content: ${snapshot.data[index]["content"]}", style: Theme.of(context).primaryTextTheme.bodyMedium),
                );
              }
            );
          }
        }
      }
      else {
        // 请求未结束，显示loading
        return const Center(child: CircularProgressIndicator());
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: const HomePageDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Home Page', style: Theme.of(context).primaryTextTheme.titleLarge, ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.inversePrimary, width: 3),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: Future.delayed(const Duration(seconds: 1), () => MongoFunction.getData({})),
                    builder: (BuildContext context, AsyncSnapshot snapshot)
                      => showDataListViewBuilder(context, snapshot)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text('Create'),
                  onPressed: () =>
                    Navigator.pushNamed(context, "/create_content"),
                )
              )
            ],
          ),
        ),
      );
    }
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Menu',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.displayLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Home', style: Theme.of(context).primaryTextTheme.bodyLarge,),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: Text('Create Content', style: Theme.of(context).primaryTextTheme.bodyLarge,),
            onTap: () {
              Navigator.pushNamed(context, '/create_content');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Sign In & Sign Up', style: Theme.of(context).primaryTextTheme.bodyLarge,),
            onTap: () {
              Navigator.pushNamed(context, '/sign_in_up');
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_run),
            title: Text('Competition', style: Theme.of(context).primaryTextTheme.bodyLarge,),
            onTap: () {
              Navigator.pushNamed(context, '/competition');
            },
          ),
        ],
      )
    );
  }
}
