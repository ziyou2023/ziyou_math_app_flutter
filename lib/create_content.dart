import 'package:flutter/material.dart';
import 'package:ziyou_math_app_flutter/mongodb.dart';


TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();


class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePage();
}

class _CreatePage extends State<CreatePage> {
  // ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 26),
  //     fixedSize: const Size(240, 60));

  Future<void> _btnSave(String title, String content, BuildContext context) async{
    var dataMap = <String, dynamic>{
      'title':title,
      'content':content
    };
    MongoFunction.addData([dataMap]);
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Create Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
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
                ],
              ),
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text('Save'),
                  onPressed: () => {
                    _btnSave(titleController.text, contentController.text, context),
                    titleController.clear(),
                    contentController.clear(),
                  }
              )
            ],
          ),
        )
    );
  }
}