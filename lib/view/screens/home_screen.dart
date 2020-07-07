import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsfeed/view/screens/pages/about_us_page.dart';
import 'package:newsfeed/view/screens/pages/head_line_page.dart';
import 'package:newsfeed/view/screens/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String _applicationKey="";
  int _currentIndex = 0;

  final _pages = [
    HeadLinePage(),
    NewsListPage(),
    AboutUsPage(),
  ];

  @override
  void initState() {
    _applicationKey = DotEnv().env['APPLICATION_KEY'];
    print(_applicationKey);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: const Icon(Icons.highlight),
                title: const Text("トップニュース"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                title: const Text("ニュース一覧"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.info),
                title: const Text("このアプリについて"),
              ),
            ],
            onTap: (index) {//itemsのリストの中のBottomNavigationBarItemの何番目をタップしたかの数字がindexに格納される
              setState(() {
                print(index);
                _currentIndex = index;
              });
            }

        ),
      ),
    );
  }
}
