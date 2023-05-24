import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  int _numberOfQuestion = 0;
  int _numberOfDifficulty = 2;

  @override
  void initState() {
    super.initState();
    _numberOfQuestion = 0;
    _numberOfDifficulty = 2;
  }

  Future<void> _btnSave(String title, String content, BuildContext context) async{
    var dataMap = <String, dynamic>{
      'title':title,
      'content':content
    };
    MongoFunction.addData([dataMap]);
    print("ziyou");
    ZiYouAPI().getProblem();
    context.go("/");
  }

  Widget buildNumberOfQuestions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(width: 10),
        Text(
          "題數",
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (_numberOfQuestion != 0) {
              setState(() {_numberOfQuestion--;});
            }
          }
        ),
        const SizedBox(width: 10),
        Text(
          "$_numberOfQuestion",
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (_numberOfQuestion <= 14) {
              setState(() {_numberOfQuestion++;});
            }
          }
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildDifficulty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: RadioListTile(
            value: 1,
            selected: true,
            groupValue: _numberOfDifficulty,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple,
            title: Text(
              "簡單",
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            onChanged: (value) {
              setState(() {_numberOfDifficulty = value!;});
            }
          )
        ),
        Flexible(
          child: RadioListTile(
            value: 2,
            selected: true,
            groupValue: _numberOfDifficulty,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple,
            title: Text(
              "中等",
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            onChanged: (value) {
              setState(() {_numberOfDifficulty = value!;});
            }
          )
        ),
        Flexible(
          child: RadioListTile(
            value: 3,
            selected: true,
            groupValue: _numberOfDifficulty,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple,
            title: Text(
              "困難",
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            onChanged: (value) {
              setState(() {_numberOfDifficulty = value!;});
            }
          )
        ),
      ],
    );
  }

  Widget buildBtnLastProblem(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left_rounded),
      onPressed: () {}
    );
  }

  Widget buildBtnNextProblem(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_right_rounded),
      onPressed: (){});
  }

  Widget buildImgProblem(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Image.asset("images/problems/pp1110110011.png"),
        ),
        Flexible(
          child: Image.asset("images/problems/pp1110110011.png"),
        )
      ]
    );
  }

  // Image.network(
  // 'https://api.emath.math.ncu.edu.tw/problem/9ab8a119b144f0040bfc0490a5b7c30e')
  //
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
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 20,),
                    // todo:難易度->RadioListTile
                    // Wrap(
                    //   alignment: WrapAlignment.center,
                    //   children: [buildDifficulty(context)],
                    // ),
                    Expanded(child: buildDifficulty(context)),
                    const SizedBox(width: 20,),
                    // todo: 題數 => finish
                    buildNumberOfQuestions(context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: <Widget>[
                    // todo: 前一題-> button
                    buildBtnLastProblem(context),
                    // todo: 題目圖片
                    buildImgProblem(context),
                    // todo: 後一題-> button
                    buildBtnNextProblem(context),
                  ],
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

// Padding(
// padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
// child: TextField(
// controller: titleController,
// autofocus: true,
// decoration: const InputDecoration(
// labelText: "Title",
// hintText: "The title is...",
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
// child: TextField(
// controller: contentController,
// maxLines: 5,
// decoration: const InputDecoration(
// labelText: "Content",
// hintText: "Write something...",
// ),
// ),
// ),
