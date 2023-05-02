import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

class MongoFunction {

  static Future<dynamic> connectDataBase(String collName) async{
    Db db = await Db.create("mongodb://mongoadmin:passwd@140.115.26.115:27017/testdb?authSource=admin");
    await db.open();
    inspect(db);
    var collection = await db.collection(collName);
    return collection;
  }

  static void addData(List<Map<String, dynamic>> data) async{
    var profile = await connectDataBase("testprofile");
    for(int i = 0; i < data.length; i++){
      data[i]['_id'] = ObjectId();
    }
    profile.insertMany(data);
  }

  static Future<List<Map<String, dynamic>>> getData(Map<String, String> target) async{
    var profile = await connectDataBase("testprofile");
    if (target.isEmpty){
      return await profile.find().toList();
    }
    else {
      return await profile.find(target).toList();
    }
  }
}
