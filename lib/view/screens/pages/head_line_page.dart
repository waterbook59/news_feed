import 'package:flutter/material.dart';
import 'package:newsfeed/data/search_type.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/view/components/head_line_item.dart';
import 'package:newsfeed/view/components/page_transformer.dart';
import 'package:newsfeed/view/screens/news_web_page_screen.dart';
import 'package:newsfeed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
//ロード中でなくかつ１件もないとき、設定したProvider.ofを使って、getNewsメソッド
    //そのまま実行するとエラー（initState内で非同期処理NG的な）
    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      //ここをgetNewsからメソッドを変更
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),

        //
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              return model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PageTransformer(
                    pageViewBuilder: (context, pageVisibilityResolver) {
                    return PageView.builder(
                      //ただインスタンスを作れば良い
                      controller: PageController(
                        //
                          viewportFraction: 0.85
                      ),
                      itemCount: model.articles.length,
                      itemBuilder: (context, int index) {
                        final article = model.articles[index];
                        final pageVisibility =
                        pageVisibilityResolver.resolvePageVisibility(index);
                        final visibleFraction = pageVisibility.visibleFraction;
                        return HeadLineItem(
                          article: model.articles[index],
                          onArticleClicked: (article) =>
                              _openArticleWebPage(article, context),
                          pageVisibility: pageVisibility,
                        );
//                          Opacity(
//                          opacity: visibleFraction,
//                          child: Container(
//                            color: Colors.blueAccent,
//                            child: Column(
//                              children: <Widget>[
//                                Text(model.articles[index].title),
//                                Text(model.articles[index].description),
//                              ],
//                            ),
//                          ),
                        });
                      },
                    );
                  }),
          ),
        ),
      );
  }

  Future<void> onRefresh(BuildContext context) async {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: viewModel.searchType);
  }


  _openArticleWebPage(Article article, BuildContext context) {
    print("HeadLinePage/_openArticleWebPage:${article.url}");

    Navigator.of(context).push(
        MaterialPageRoute(
        builder: (context)=>NewsWebPageScreen(article: article,)
    ));

  }
//    print("HeadLinePage onRefresh");

}
