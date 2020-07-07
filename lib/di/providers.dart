import 'package:flutter/material.dart';
import 'package:newsfeed/models/db/dao.dart';
import 'package:newsfeed/models/db/database.dart';
import 'package:newsfeed/models/repository/news_repository.dart';
import 'package:newsfeed/viewmodels/head_line_viewmodel.dart';
import 'package:newsfeed/viewmodels/news_list_viewmodel.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:newsfeed/models/networking/api_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

//誰にも依存してないのは、末端のApiService
List<SingleChildWidget> independentModels =[
  Provider<ApiService>(
    create: (context) => ApiService.create(),
    dispose: (context, apiService) => apiService.dispose(),
  ),
  Provider<MyDatabase>(
    create: (context) => MyDatabase(),
    dispose: (context,db) =>db.close(),
  ),
];

List<SingleChildWidget> dependentModels =[
  ProxyProvider<MyDatabase, NewsDao>(
    update: (context, db, dao)=> NewsDao(db),
  ),
  ProxyProvider2<NewsDao, ApiService, NewsRepository>(
    update: (context,dao,apiService,repository)=>NewsRepository(dao:dao,apiService:apiService),
  )
];

List<SingleChildWidget> viewModels =[
  ChangeNotifierProvider<NewsListViewModel>(
    create: (context) => NewsListViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false)
    ),
  ),
  ChangeNotifierProvider<HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      repository: Provider.of<NewsRepository>(context, listen:false)
    ),
  ),
];
