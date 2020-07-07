import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  final ValueChanged onSearch;
  //stateless widgetなのでフィールドはimmutable(石)にしないといけないのでfinal
  final TextEditingController _textEditingController = TextEditingController();

  /*TextFieldに入力された情報が、final ValueChanged onSearch;に入り、
  呼び出し元(news_list_page)のSearchBar関数の名前つき引数で設定してやると、TextFieldの入力情報が渡る
   */
  SearchBar({this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(24.0))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: TextField(
          onSubmitted: onSearch,
          maxLines: 1,
          controller: _textEditingController,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: "検索ワードを入れてください",
            border: InputBorder.none),
          ),
      ),
    );
  }
}
