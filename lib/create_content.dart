import 'package:flutter/material.dart';
import 'package:ziyou_math_app_flutter/mongodb.dart';
import 'package:ziyou_math_app_flutter/ziyou_api.dart';

TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();


class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePage();

}

class _CreatePage extends State<CreatePage> {

  Future<void> _btnSave(String title, String content, BuildContext context) async{
    var dataMap = <String, dynamic>{
      'title':title,
      'content':content
    };
    MongoFunction.addData([dataMap]);
    print("ziyou");
    ZiYouAPI().getProblem();
    Navigator.pushNamed(context, "/");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Create Page', style: Theme.of(context).primaryTextTheme.titleLarge, ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    hintText: "The title is...",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: TextField(
                  controller: contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: "Content",
                    hintText: "Write something...",
                  ),
                ),
              ),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                child: const Text('Save'),
                onPressed: () => {
                  _btnSave(titleController.text, contentController.text, context),
                  titleController.clear(),
                  contentController.clear(),
                }
              ),
            ],
          ),
        )
      )
    );
  }
}
