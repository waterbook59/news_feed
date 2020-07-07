//いわゆるレポジトリ層

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/data/category_info.dart';
import 'package:newsfeed/data/search_type.dart';
import 'package:newsfeed/main.dart';
import 'package:newsfeed/models/db/dao.dart';
import 'package:newsfeed/models/model/news_model.dart';
//step8(chapter53).さらなる外注先api_service.dartをimport
import 'package:newsfeed/models/networking/api_service.dart';
import 'package:newsfeed/util/extension.dart';
//必要ならapi_service.chopperもimport
//import 'package:newsfeed/models/networking/api_service.chopper.dart';

class NewsRepository  {

//  static String _text ="ここにキー";  //ここで.envのapiキーを渡せないか？？？
  //step8(chapter53).さらなる外注先のApiServiceのインスタンス化、クライアント取ってくる

  //final ApiService _apiService = ApiService.create();
  final ApiService _apiService;
  final NewsDao _dao;

 NewsRepository({dao, apiService})//7つのコンストラクタ初期化リスト
  : _apiService = apiService,
    _dao = dao;


  //ViewModel側からこのメソッドを名前付で呼び出す
 //ここの結果をnews_list_viewmodelのgetNewsメソッドの中で_articles に代入する
  Future<List<Article>> getNews({@required SearchType searchType,String keyWord, Category category })async{
//    print("repository/ $searchType, $keyWord, ${category.nameJp}");
  //varがふさわしいが、わかりやすいようにResponseで記載
   Response response;
   //apiServiceから得られた結果格納するList<Article>インスタンス
   List<Article> result =List<Article>();

  //step9. try-catchで３通り場合分け
  try{
    //step8(chapter53)今回取得処理をApiServiceクラス内で作ったリクエスト用メソッドで場合分けし、ApiServiceへ外注
    switch(searchType){
      case SearchType.HEAD_LINE:
      //非同期なので、await忘れない,
      //_apiService.getHedLines()の戻り値responseなので代入
        response =await _apiService.getHedLines();
        break;
      case SearchType.KEYWORD:
        response =await _apiService.getKeywordNews(keyword: keyWord);
        break;
      case SearchType.CATEGORY:
        //検索するときはnameEn
        response =await _apiService.getCategoryNews(category: category.nameEn);
        break;
    }
    if(response.isSuccessful){
      final responseBody = response.body;
      print("responseBody:$responseBody");
      /*resultはなぜ末尾に.articlesかというと、
      モデルクラスであるNewsクラス内のfactoryメソッド(fromJson(responseBody))を使ってJsonをモデルクラスに変換してそのarticles属性を取ってきている
       */
      //result = News.fromJson(responseBody).articles;
      result = await insertAndReadFromDB(responseBody);

    }else{
      final errorCode = response.statusCode;
      final error =response.error;
      print("response is not successful:$errorCode,$error");
    }
  } on Exception catch(error){
    print("error:$error");
  }
  return result;
  }//getNews終わり

//step.10 Repositoryを破棄=>ApiService.disposeを破棄、破棄しとかないとアプリ閉じても取得し続けてしまう
 void dispose(){
    _apiService.dispose();
 }

 //最終的にNewsListViewModelへ返す形（上のFuture<List<Article>> getNews参照）
  Future<List<Article>> insertAndReadFromDB(responseBody) async{
    //「.newsDao」はdatabase.g.dart(_$MyDatabaseクラス)内で作ったゲッター
    // NewsDaoクラスのインスタンスと捉えて、「dao.クエリメソッド」でNewsDaoクラス内のクエリを引っ張ってこれる
//    final dao =myDatabase.newsDao;
    final articles = News.fromJson(responseBody).articles;//News.fromJson(jsonデータ)でモデルクラス(News)へ変換(articleRecordsじゃないよ)

    //todo webから取得した記事リスト(Dartのモデルクラス：Article)をDBのデーブルクラス(ArticleRecords)に変換してDB登録/DBから取得
//    final articleRecords =await dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));
    final articleRecords =await _dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));

    //todo DBから取得したデータをモデルクラスに再変換して返す
    return articleRecords.toArticles(articleRecords);
  }


}