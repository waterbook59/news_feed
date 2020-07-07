import 'package:flutter/material.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:newsfeed/view/components/page_transformer.dart';

class LazyLoadText extends StatelessWidget {

  final String text;
  final PageVisibility pageVisibility;

  LazyLoadText({this.text, this.pageVisibility,});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.subtitle1;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        //このAlignmentの違いは？？？topLeftもbottomRightもあまり変わらない感じ
        alignment: Alignment.topLeft,
        transform: Matrix4.translationValues(pageVisibility.pagePosition * 200, 0.0, 0.0),
        child: Text(
          text, style: textTheme.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
      ),
    );
  }
}
