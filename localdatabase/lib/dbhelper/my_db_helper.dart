import 'package:localdatabase/model/contact.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Mydbhelper {
  static Future<Database> initdb() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'contact.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql =
        '''CREATE TABLE tbl_contact(id INTEGER PRIMARY KEY,name Text,phone Text)''';
    await db.execute(sql);
  }

  static Future<int> createContact(Contact contact) async {
    Database db = await Mydbhelper.initdb();
    return await db.insert("tbl_contact", contact.toMap());
  }

  static Future<List<Contact>> readContact() async {
    Database db = await Mydbhelper.initdb();
    var contact = await db.query('tbl_contact');

    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }

  static Future<int> updateContact(Contact contact) async {
    Database db = await Mydbhelper.initdb();
    return await db.update("tbl_contact", contact.toMap(),
        where: "id=?", whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(id) async {
    Database db = await Mydbhelper.initdb();
    return await db.delete('tbl_contact', where: "id=?", whereArgs: [id]);
  }
}
