import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEditMemoPage extends StatefulWidget {
  final QueryDocumentSnapshot? memo; //型名の後ろに?つけたら　変数がNullableになる
  AddEditMemoPage({ this.memo});

  @override
  State<AddEditMemoPage> createState() => _AddEditMemoPageState();
}

class _AddEditMemoPageState extends State<AddEditMemoPage> {
  TextEditingController titleController = TextEditingController(); //入力内容を司る
  TextEditingController detailController = TextEditingController();

  Future<void> addMemo() async{
    var collection = FirebaseFirestore.instance.collection("memo");
    collection.add({
      "title": titleController.text, //titleというフィールドに対してtitlecontrollerで司った内容を入れる
      "detail": detailController.text,
      "created_date": Timestamp.now() //現在時刻を入れる
    });
  }

  Future<void> updatedMemo() async{
    var document =FirebaseFirestore.instance.collection("memo").doc(widget.memo!.id); //編集した内容を取得してくる
    document.update({ //document.updataというメソッドで更新する
      "title": titleController.text, //titleに関してはtitleControllerの内容を更新
      "detail": detailController.text,
      "updated_time": Timestamp.now()
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.memo != null){
      titleController.text = widget.memo!["title"]; //入力内容を保持するのはtitleController、nullじゃない場合は編集、これまでのtextを表示する
      detailController.text=widget.memo!["detail"];

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null ? "メモを追加" : "メモを編集"), //widget.memoがnullであればメモを追加 ?と:を使う
      ),
      body: Center(
        child: Column( //todo Collumは縦に並べる
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text("タイトル"),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0), //入力欄の上部を15くらい空ける
              child: Container(
                decoration: BoxDecoration(      //入力欄の作成 decoration:みたいなやつは decolationというライブラリの中のBoxDecoration(),という関数を使っているみたいなイメージかな？
                  border: Border.all(color: Colors.grey)

                ),
                  width:MediaQuery.of(context).size.width * 0.8, //todo MediaQuery.of(context).size.width⇨画面幅をとる
                  child: TextField( //todo 入力部分、containerで作成した入力欄の子要素
                    controller: titleController,
                    decoration: InputDecoration( //入力のデザインを決める
                        border: InputBorder.none, //入力時の下の線を削除
                        contentPadding: EdgeInsets.only(left: 10) //todo 入力欄の左側に10くらいの余白ができる
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text("メモ内容"),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Container(
                  decoration: BoxDecoration(      //todo decoration:みたいなやつは decolationというライブラリの中のBoxDecoration(),という関数を使っているみたいなイメージかな？
                      border: Border.all(color: Colors.grey)

                  ),
                  width:MediaQuery.of(context).size.width * 0.8, //todo MediaQuery.of(context).size.width⇨画面幅をとる
                  child: TextField(
                    controller: detailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10) //todo 入力欄の左側に10くらいの余白ができる
                    ),
                  )
              ),
            ),
            Padding(  //余白の調整
              padding: const EdgeInsets.only(top:30.0),
              child: Container(
                width:MediaQuery.of(context).size.width*0.8 ,
                alignment: Alignment.center, //この処理で子ウィジェットの配置を真ん中に設定した
                child: RaisedButton( //この辺のchild：は自分で書いてない、まずchildren[]の並列要素としてRaisedButtonを入力し、wrap containerを選択したら自動で出てくる
                  color: Theme.of(context).primaryColor, //テーマの色にボタンを合わせる
                  onPressed: () async{
                  //メモ追加の処理を書いていく
                    if(widget.memo ==null) {
                      await addMemo(); //addMemoという操作は時間がかかる。async~awaitをしておかないと追加してないのにページがpopされると言ったことが起きる
                    } else {
                      await updatedMemo(); //Futureで宣言した名前
                    }
                    Navigator.pop(context); //addmemoページをpopしてtopページに行く

                },
                  child: Text(widget.memo == null ?"追加" : "編集", style: TextStyle(color: Colors.white)) //　[重要]　raisedButtonの子ウィジェットにテキストを入れるという関係になっている

                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
