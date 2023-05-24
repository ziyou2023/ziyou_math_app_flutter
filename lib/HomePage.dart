import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'mongodb.dart';


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
                  onPressed: () => context.go("/create_content"),
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
              onTap: () => context.go("/"),
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: Text('Create Content', style: Theme.of(context).primaryTextTheme.bodyLarge,),
              onTap: ()  => context.go("/create_content"),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Sign In & Sign Up', style: Theme.of(context).primaryTextTheme.bodyLarge,),
              onTap: ()  => context.go("/sign_in_up"),
            ),
            ListTile(
              leading: const Icon(Icons.directions_run),
              title: Text('Competition', style: Theme.of(context).primaryTextTheme.bodyLarge,),
              onTap: ()  => context.go("/competition"),
            ),
          ],
        )
    );
  }
}
