//どのクラスを拡張するさせるかというと、webから取ってきたデータはListなので、
//Listを拡張する

import 'package:newsfeed/models/db/database.dart';
import 'package:newsfeed/models/model/news_model.dart';

//Dartのモデルクラス=> DBのテーブルクラス
extension ConvertToArticleRecord on List<Article>{
 //下の文頭のList<ArticleRecord>は戻り値の型 toArticleRecords(引数)で
  //引数のList<Article> articlesは、webから取ってきたデータのリスト（モデルクラス全行分）
  List<ArticleRecord> toArticleRecords(List<Article> articles){
    var articleRecords = List<ArticleRecord>();//ジェネリクスはデフォルトでも入れておく

    //モデルクラス全行分List(引数のarticles)を１行分に分けて(forEach)をそれぞれデータベースのテーブルクラスへ変換
    // Listのだいたい複数形の名前.forEach((引数だいたいList単数形にする)=>関数)：Listを1行分ずつ反復して出してくれる
    articles.forEach((article) {
      articleRecords.add(//上で作ったからのリストへ格納していく
        ArticleRecord(
          title: article.title ?? "",
          description: article.description ?? "",
          url: article.url,
          urlToImage: article.urlToImage ?? "",
          publishDate:  article.publishDate ?? "",
          content:  article.content ?? "",
        )
      );
    });
    return articleRecords;
  }
}

//DBのテーブルクラス=> Dartのモデルクラス
extension ConvertToArticle on List<ArticleRecord>{

  List<Article> toArticles(List<ArticleRecord> articleRecords){
    var articles = List<Article>();

    articleRecords.forEach((articleRecord) {
      articles.add(//上で作ったからのリストへ格納していく
          Article(
            title: articleRecord.title ?? "",
            description: articleRecord.description ?? "",
            url: articleRecord.url,
            urlToImage: articleRecord.urlToImage ?? "",
            publishDate:  articleRecord.publishDate ?? "",
            content:  articleRecord.content ?? "",
          )
      );
    });
    return articles;
  }
}