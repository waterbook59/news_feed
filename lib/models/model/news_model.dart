//いわゆるモデルクラス（返ってきたデータを格納するクラスを一般的にモデルクラスという）
//JSONで返ってきたレスポンスを@JsonSerializableを使ってDartへ変換
//@JsonSerializableはmapsタイプ(ビルトイン型(コンストラクタ使わずインスタンス作れる)の一つ)をdartに変換

//step7 取得結果格納のためのモデルクラス作成

import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

//NEWS APIのarticleのJSON構造が２階層(全部で３階層)になってるので、階層ごとにクラス設定必要
@JsonSerializable()//かっこ必要でコンストラクタになっている
class News{
  final List<Article> articles;
  //名前付きコンストラクタ設定
  News({this.articles});

  //JSONからモデルclass,モデルclassからJSONに変換するメソッド設定
  //このメソッドを使うことでJsonデータをモデルクラスに変換してDartで使えるようになる

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Article {
  //全部Stringでおっけー
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  @JsonKey(name:"publishedAt") final String publishDate;
  final String content;

  Article({this.title, this.description, this.url, this.urlToImage,this.publishDate, this.content});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
