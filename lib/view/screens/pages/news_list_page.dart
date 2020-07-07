import 'package:flutter/material.dart';
import 'package:newsfeed/data/category_info.dart';
import 'package:newsfeed/data/search_type.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/view/components/article_tile.dart';
import 'package:newsfeed/view/components/category_chips.dart';
import 'package:newsfeed/view/components/search_bar.dart';
import 'package:newsfeed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../news_web_page_screen.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//chapter.56 開いたときにデータ取得
  final viewModel = Provider.of<NewsListViewModel>(context,listen: false);
//ロード中でなくかつ１件もないとき、設定したProvider.ofを使って、getNewsメソッド
  //そのまま実行するとエラー（initState内で非同期処理NG的な）
    if(!viewModel.isLoading && viewModel.articles.isEmpty){
      Future(()=>viewModel.getNews(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          //contextを引数に持ってきているのは？？
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // 検索ワード
              SearchBar(onSearch: (keyword)=>getKeywordNews(context, keyword),
              ),
              CategoryChips(
                //category_chips.dartのwidget.onCategorySelected(categories[index])へ渡すためのコンストラクタ値を設定する
                onCategorySelected: (category)=>getCategoryNews(context, category),
              ),
              // 記事表示(グリグリ) chapter57でConsumer
              Expanded(child: Consumer<NewsListViewModel>(
                builder: (context,model,child){
                  return model.isLoading
                      ? Center(child: CircularProgressIndicator())
                      :ListView.builder(
                        itemCount:model.articles.length,
                        itemBuilder:(context,int position)
                        => ArticleTile(
                          article: model.articles[position],
                          onArticleClicked: (article)=>_openArticleWebPage(article,context),
                        )

//                        ListTile(
//                          title: Text(model.articles[position].title),
//                          subtitle: Text(model.articles[position].description),
//                        )
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  // 記事更新処理
  Future<void> onRefresh(BuildContext context) async{
    final viewModel = Provider.of<NewsListViewModel>(context,listen: false);
    //chapter25.providerが4.1以上はcontexte.watch,context.readが使える
 // final viewModel = context.read<NewsListViewModel>();
   await viewModel.getNews(searchType: viewModel.searchType,keyWord: viewModel.keyword,category: viewModel.category);
//    print("NewsListPage.onRefreshed:$context");
  }

  // キーワード記事取得処理
  Future<void> getKeywordNews(BuildContext context, keyword) async{
    //viewから外注するだけなのでlisten:false

    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(searchType: SearchType.KEYWORD,keyWord: keyword,category: categories[0],);
//    print("NewsListPage.getKeywordNews:$keyword,$context");
  }

  // カテゴリー記事取得処理
  Future<void> getCategoryNews(BuildContext context, Category category) async{
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
   await viewModel.getNews(searchType: SearchType.CATEGORY,category: category);
//    print("NewsListPage.getCategoryNews/category:${category.nameJp},$context");
  }

  //
  _openArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage:${article.urlToImage}");

    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context)=>NewsWebPageScreen(article: article,)
        ));
  }
}
