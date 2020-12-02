import 'dart:async';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
part 'moor_database.g.dart';

@DataClassName("HeroDB")
class Heroes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get intelligence => text()();
  TextColumn get speed => text()();
  TextColumn get power => text()();
  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Heroes])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<HeroDB>> get watchAllHeroes => select(heroes).watch();

  Future<int> addHero(HeroDB hero) {
    return into(heroes).insert(hero);
  }

  Future<int> deleteHero(HeroDB hero) {
    return delete(heroes).delete(hero);
  }

  Future<List<HeroDB>> getHeroesByName(String name) {
    return (select(heroes)..where((tbl) => tbl.name.like('%' + name + '%')))
        .get();
  }

  Future<List<HeroDB>> getAllHeroes(String name) {
    return select(heroes).get();
  }

  Stream<HeroDB> getHero(String name) {
    return (select(heroes)..where((tbl) => tbl.name.equals(name)))
        .watchSingle();
  }
}
