import 'package:moor/moor.dart';//DatabaseAccessorをimportするときにmoor_webじゃない！！！
import 'database.dart';

part 'dao.g.dart';

@UseDao(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDatabase>  with _$NewsDaoMixin {//<MyDatabese>{}まで書いたらコード生成
  NewsDao(MyDatabase db) : super(db);

  //この下にクエリ書いていく
  //DBを消してから新しくデータベースを追加する
  //テーブル全部の行(articleRecords)消す
  Future clearDB() => delete(articleRecords).go();

  //リスト形式でArticleRecord(１行分データ)を入れる
  //2行以上insertする場合batchを使う、要はリストで一気に入れたい場合はbatch使う
  Future insertDB(List<ArticleRecord> articles) async {
    await batch((batch) {
      batch.insertAll(articleRecords, articles);
    });
  }

  Future<List<ArticleRecord>> get articlesFromDB =>
      select(articleRecords).get();

  //2つ以上のクエリをまとめてやる=>transaction
  Future<List<ArticleRecord>> insertAndReadNewsFromDB(
      List<ArticleRecord> articles) =>
      transaction(() async {
        await clearDB();
        await insertDB(articles);
        return await articlesFromDB;
      });
}