import 'package:bytebankbd/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bytebank.db');
  //   return openDatabase(path, onCreate: (db, version) {
  //     db.execute('CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)');
  //   }, version: 1,
  //  // onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });

  //com async await
  //final String dbPath = await getDatabasesPath();
  //final String path = join(dbPath, 'bytebank.db');
  //ou
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1,
      // onDowngrade: onDatabaseDowngradeDelete, //avança versão + 1 depois volta menos 1 dai ele deleta
    );
}

Future<int> save(Contact contact) async {
  // return createDatabase().then((db) {
  //   final Map<String, dynamic> contactMap = Map();
  //   //contactMap['id'] = contact.id;
  //   contactMap['name'] = contact.name;
  //   contactMap['account_number'] = contact.accountNumber;
  //
  //   return db.insert('contacts', contactMap);
  // });

  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async{
  // return createDatabase().then((db) {
  //   return db.query('contacts').then((maps) {
  //     final List<Contact> contacts = List();
  //     for (Map<String, dynamic> map in maps) {
  //       final Contact contact = Contact(
  //         map['id'],
  //         map['name'],
  //         map['account_number'],
  //       ); //campo do banco no map
  //       contacts.add(contact);
  //     }
  //     return contacts;
  //   });
  // });

  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result  = await db.query('contacts');
  final List<Contact> contacts = List();

  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    ); //campo do banco no map

    contacts.add(contact);
  }
  return contacts;
}
