import 'package:flutter/material.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/view/style/style.dart';

class ArticleTitleDesc extends StatelessWidget {

  final Article article;
  const ArticleTitleDesc({this.article});

  @override
  Widget build(BuildContext context) {
    //このcontext(MaterialApp)のThemeのtextThemeという意味
    final textTheme = Theme.of(context).textTheme;

    //descriptionはnullの場合があるので、nullの時は""を入れる
    var displayDesc ="";
    if(article.description != null){
      displayDesc = article.description ;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(article.title, style: textTheme.subtitle1.copyWith(
        fontWeight: FontWeight.bold
      ),),
      SizedBox(height: 2.0,),
      Text(article.publishDate,style: textTheme.overline.copyWith(
        fontStyle: FontStyle.italic
      ),),
        SizedBox(height: 2.0,),
      Text(displayDesc,style: textTheme.bodyText2.copyWith(
        fontFamily: RegularFont
      ),),
    ],);
  }
}
