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
  int currentIndex = 0;
  String _problemIndex = "pp11101";

  @override
  void initState() {
    super.initState();
    _numberOfQuestion = 0;
    _numberOfDifficulty = 2;
    currentIndex = 0;
  }

  Future<void> _btnSave(String title, String content, BuildContext context) async{
    var dataMap = <String, dynamic>{
      'title':title,
      'content':content
    };
    MongoFunction.insertData(dataMap);
    print("ziyou");
    ZiYouAPI().getProblem();
    context.go("/");
  }

  Widget buildNumberOfQuestions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            "題數",
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.loose,
          child: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (_numberOfQuestion != 0) {
                  setState(() {_numberOfQuestion--;});
                }
              }
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            "$_numberOfQuestion",
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_numberOfQuestion <= 14) {
                  setState(() {_numberOfQuestion++;});
                }
              }
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildDifficulty(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  Widget buildBtnPreviousProblem(BuildContext context, int currentIndex) {
    return Flexible(
      fit: FlexFit.loose,
      child: IconButton(
        icon: const Icon(Icons.arrow_left),
        onPressed: () {
          // currentIndex = (currentIndex - 1);
        }
      ),
    );
  }

  Widget buildBtnNextProblem(BuildContext context, int currentIndex) {
    return Flexible(
      fit: FlexFit.loose,
      child: IconButton(
        icon: const Icon(Icons.arrow_right),
        onPressed: () {
          // currentIndex = (currentIndex + 1);
        }
      ),
    );
  }

  Widget buildImgProblem(BuildContext context, int currentIndex) {
    return Flexible(
      child: Container(
        width: 700,
        height: 450,
        child: Image.asset("images/problems/pp1110110011.png", fit: BoxFit.cover),
      ),
    );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildNumberOfQuestions(context),
                    // buildDifficulty(context),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildBtnPreviousProblem(context, currentIndex),
                    const SizedBox(width: 20.0),
                    buildImgProblem(context, currentIndex),
                    const SizedBox(width: 20.0),
                    buildBtnNextProblem(context, currentIndex),
                  ],
                ),
                const SizedBox(height: 20.0),
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
          ),
      )
    );
  }
}
