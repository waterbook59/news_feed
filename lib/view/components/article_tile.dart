import 'package:flutter/material.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/view/components/article_title_desc.dart';
import 'package:newsfeed/view/components/image_from_url.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final ValueChanged onArticleClicked;//押したときにwebのurlを入れる形にしたいので、引数付きのValueChanged

  const ArticleTile({this.article,this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(//クリックすると波紋する効果
          onTap: () => onArticleClicked(article),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  //名前付きコンストラクタを呼び出すときは、名前：を忘れずに（値だけを入れない）
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageFromUrl(imageUrl:article.urlToImage),
                  )
              ),
              Expanded(
                flex: 3,
                //todo
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ArticleTitleDesc(article: article,),
                ),
//


              )
            ],
          ),
        ),
      ),
    );
  }
}
