//いわゆるviewModel層
import 'package:flutter/material.dart';
import 'package:newsfeed/data/category_info.dart';
import 'package:newsfeed/data/search_type.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/models/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier{
  //ChangeNotifierからrepositoryへさらに外注をする為、NewsRepositoryのインスタンス作成
  //final NewsRepository _repository = NewsRepository();

  final NewsRepository _repository;

  HeadLineViewModel({repository}):
      _repository =repository;


  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  //CircularProgressIndicatorがロード中か否かのYES/NO
  bool _isLoading =false;
  bool get isLoading => _isLoading;
  List<Article> _articles =List();//初期化
  List<Article> get articles => _articles;


  Future<void> getNews({@required SearchType searchType,String keyWord, Category category }) async{

    //view層から指定された値をviewmodel層にセット
    _searchType = searchType;
    _keyword = keyWord;
    _category = category;

    _isLoading = true;
    notifyListeners();

    _articles = await _repository.getNews(searchType: _searchType,keyWord: _keyword, category: _category);

    print("searchType:$_searchType／ keyWord:$_keyword／ category${_articles[0].title}");

    _isLoading = false;
    notifyListeners();

  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  Future<void> getHeadLines({@required SearchType searchType}) async{
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();
    //レポジトリでrequiredの引数はsearchTypeだけ
    _articles = await _repository.getNews(searchType: _searchType);
    print("searchType:$_searchType／articletitles: ${articles[0].title}");
    _isLoading = false;
    notifyListeners();
  }
}