import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';

class MemoPage extends StatelessWidget {
  final QueryDocumentSnapshot memo;
  MemoPage(this.memo); //Todo メモページに来る際にはMemoクラスの変数をもってこいってことを意味する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(memo["title"])
      ),
      body: Center(
        child: Column(//Columnウィジェット⇨文字を縦に積む
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("メモ内容", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(memo["detail"], style: TextStyle(fontSize: 18)) //ToDO,は並列と考えて良いのかな？;は大きな括りの締めで使う感じ
          ],

        ),
      ),
    );
  }
}
