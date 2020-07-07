//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:newsfeed/di/providers.dart';
import 'package:newsfeed/models/db/database.dart';
import 'package:newsfeed/view/style/style.dart';
import 'package:newsfeed/viewmodels/head_line_viewmodel.dart';
import 'package:newsfeed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'view/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//MyDatabase myDatabase;

void main() async{
  //flutter_dotenv
  await DotEnv().load('.env');
//  myDatabase =MyDatabase();
  runApp(
    MultiProvider(
      providers: globalProviders,
//      providers: [
//        ChangeNotifierProvider(
//          //create:(context)のcontextは実行する関数の方で使わないので(_)でも良い
//          //NewsListViewModelのインスタンスを特定のウィジェットへ与えることができる
//          create: (context) => NewsListViewModel(),
//        ),
//        ChangeNotifierProvider(
//          create: (context)=>HeadLineViewModel(),
//        ),
//      ],
      child: MyApp(),
    )

  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
