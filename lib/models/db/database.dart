import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:newsfeed/models/db/dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

//Tableクラスはmoor.dartをimport
//データベースで作るテーブルの項目を独立させるため、モデルクラス(Article)とは別の名前にする
//1行分のデータをArticleRecordという名前にする(ArticleRecordクラスが存在する場所はdatabase.g.dart内)
class ArticleRecords extends Table {
  //ここはテーブルの縦の項目(カラム)設置のイメージ
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {url};
}

//復習@UseMoorはmoor generatorにArticleRecordというデータクラスを作るように知らせる付加情報のこと
//初級編chapter208参照
@UseMoor(tables: [ArticleRecords],daos: [NewsDao])
class MyDatabase extends _$MyDatabase{ //class MyDatabase{}まで書いたらコード生成(.g.dart)して良い
  //_openConnectionは関数(top level function)メソッドではない
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {

  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    //pathプロパイダーの設定は他のパッケージでも同様なので
    final file = File(p.join(dbFolder.path, 'news.db'));//dart.ioの方をインポート！！
    return VmDatabase(file);
  });

}