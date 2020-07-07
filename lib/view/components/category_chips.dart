import 'package:flutter/material.dart';
import 'package:newsfeed/data/category_info.dart';

//CategoryChipsはStatefulなのはなぜ？
class CategoryChips extends StatefulWidget {

  final ValueChanged onCategorySelected;
  CategoryChips({this.onCategorySelected});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  var value =0;

  @override
  Widget build(BuildContext context) {
    //Wrapで囲っていると行をまたいで表示してくれる
    // 参考：ChoiceChip class
    return Wrap(
      spacing: 4.0,
      children: List<Widget>.generate(categories.length, (int index){
       return ChoiceChip(
          label:Text(categories[index].nameJp),
          selected: value == index,//選んだindexを使いたいので、indexをするための変数valueを設定
          //onSelected:の入力値にはValueChanged<bool>となっているので、選ばれた時には(true)が入り、選ばれない時には(false)が返ってくる
          onSelected: (bool isSelected){
            setState(() {
              //valueがtrueならindex代入、falseなら0代入
              value =isSelected ?index :0;
              /*
              news_list_pageの呼び出し元からonCategorySelectedにはValueChanged関数が設定されている
              ValueChangedClassは引数あり関数なので(categories[index])
              (category)=>getCategoryNews(context, category)のcategoryの部分にcategories[index]が入るイメージ
              fieldに引数が設定される関数が設定されている場合、widget.field名(代入する値)
              */
              widget.onCategorySelected(categories[index]);
            });
          },
        );
      }).toList()
    );
  }
}
