//いわゆるviewModel層
//ChangeNotifierというクラスはflutterのSDKにもともと入っている
//(ChangeNotifierProviderはproviderパッケージに入っている）
import 'package:flutter/material.dart';
import 'package:newsfeed/data/category_info.dart';
import 'package:newsfeed/data/search_type.dart';
//格納するモデルクラスは参照しないともってこれないのでimport
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/models/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier{

  //ChangeNotifierからrepositoryへさらに外注をする為、NewsRepositoryのインスタンス作成
//  final NewsRepository _repository = NewsRepository();

  final NewsRepository _repository;
  NewsListViewModel({repository}):_repository =repository;

  //viewからviewModelへ外注されるのでenumのstatusをプロパティとしてもっとく
  //_searchTypeはクラスの外からアクセスできない
 //ゲッターを使って、値をむやみに変更されずに、値だけをクラス外から取得することができる=>つまりカプセル化
  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  //CircularProgressIndicatorがロード中か否かのYES/NO
  bool _isLoading =false;
  bool get isLoading => _isLoading;

  //step8(chapter53) 戻り値指定せずにレポジトリから取ってきたデータをここに入れる用
  //このフィールドにレポジトリのgetNewsから返ってきたresult(List<Article>)が格納される
  List<Article> _articles =List();//初期化
  //カプセル化、発注元からデータをいじられることなく引っ張ってこれる
  List<Article> get articles => _articles;

  //view側からこのメソッドを名前付で呼び出す
  //getNewsメソッドの引数を名前付引数として設定する getNews(クラスの種類 変数名）
  //getNews(A,B,C)  => getNews(int index, String title, bool isTest)など
  //notifyListenersで通知するので、戻り値の型はvoidのままで良い
  Future<void> getNews({@required SearchType searchType,String keyWord, Category category }) async{

    //view層から指定された値をviewmodel層にセット
    _searchType = searchType;
    _keyword = keyWord;
    _category = category;

    _isLoading = true;
    notifyListeners(); //[重要！]このメソッドによってChangNotifierProviderへ変更通知がいく
    //main.dartのChangeNotifierProviderに伝わって、view層にあるNewsListViewModel()のインスタンスの中ではロードされている状態になる

//    print("viewModel／$searchType, $keyWord, ${category.nameJp}");

    //TODO ここでmodel層へデータ取ってくるように外注
    //レポジトリから取ってきたデータをViewModel層内のプロパティに格納してnotifyListenersで通知
    //step8(chapter53) レポジトリから取ってきたデータをプロパティに格納(クラス内なので、_articlesに代入(articlesじゃないよ))
    //レポジトリのgetNewsからresult(List<Article>)が返ってくる
    _articles = await _repository.getNews(searchType: _searchType,keyWord: _keyword, category: _category);

    print("searchType:$_searchType／ keyWord:$_keyword／ category${_articles[0].title}");

    _isLoading = false;
    notifyListeners();

  }

  //step.10 Repositoryを破棄=>ApiService.disposeを破棄
  // ChangeNotifierProviderでNewsListViewModelインスタンスが破棄されるタイミングでdisposeメソッドが呼ばれる
  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}