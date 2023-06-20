import 'package:mongo_dart/mongo_dart.dart';

class MongoFunction {
  static Db? _db;
  static const String _collectionName = 'testprofile';

  static Future<void> connectToDatabase() async {
    final Db db = await Db.create('mongodb://admin:password@140.115.26.115:27017/testdb?authSource=admin');
    await db.open();
    _db = db;
  }

  static Future<void> insertData(Map<String, dynamic> data) async {

    if (_db == null) {
      throw Exception('Database connection not established.');
    }

    final collection = _db!.collection(_collectionName);
    await collection.insert(data);
  }

  static Future<List<Map<String, dynamic>>> searchData(String keyword) async {
    if (_db == null) {
      throw Exception('Database connection not established.');
    }

    final collection = _db!.collection(_collectionName);
    // final query = where
    //   .or([
    //   {'field1': RegExp(keyword, caseSensitive: false)},
    // //   // where.match('field1', RegExp(keyword, caseSensitive: false) as String),
    // //   // Add more fields as necessary
    //   ] as SelectorBuilder).sortBy('field_to_sort_by');

    final result = await collection.find().toList();
    // if (result.isEmpty)
    return result.map((document) => document).toList();
  }
}
