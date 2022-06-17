import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/pages/add_edit_memo_page.dart';
import 'package:memo_app/pages/memo_page.dart';

import '../model/memo.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  late CollectionReference memos;

  Future<void> deleteMemo(String docId) async{
    var document = FirebaseFirestore.instance.collection("memo").doc(docId);
    document.delete();

  }
  @override
  //ビルドの前の処理、ビルドの上に書く。getMemoでメモを取得
  void initState() {
    // TODO: implement initState
    super.initState();
    memos = FirebaseFirestore.instance.collection("memo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase × Flutter"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: memos.snapshots(), //Firebaseのmemoドキュメントの増減に反応してbuilderを動かす役割

        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          return ListView.builder( //複数のwidgetを自動生成するもの
              itemCount: snapshot.data!.docs.length, //itemCount⇨memolist.lengthでメモの数をはかり、その文下の処理を繰り返す//リスト生成数を設定
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data!.docs[index]['title']), //memolistのindexのtitleをlistTileで表示、indexは初期値0で繰り返されるたび+1
                  //detabaseの上から順に表示される
                  trailing: IconButton( //listtileの右側に表示したい場合このtrailingプロパティを利用
                    icon: Icon(Icons.edit),
                    onPressed: (){ //押されたら
                      showModalBottomSheet(context: context, builder: (context){
                        return SafeArea( //SafeArea ⇨wrap with WidhgetでWidgetの部分をSafeAreaに書き換えた。ボトムシートの下側に最低限の安全エリアを作る
                          child: Column(
                            mainAxisSize: MainAxisSize.min, //必要最低限のbottomsheetしか出ない
                            children: [
                              ListTile(
                                leading: Icon(Icons.edit, color: Colors.blueAccent,), //leadingは左
                                title: Text("編集"),
                                onTap: (){
                                  Navigator.pop(context); //編集ボタンをクリックしたらボトムページはポップしておく,編集後toppageに遷移できるように
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddEditMemoPage(memo: snapshot.data!.docs[index])));

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.delete, color: Colors.redAccent),
                                title: Text("削除"),
                                onTap: () async{
                                  await deleteMemo(snapshot.data!.docs[index].id);
                                  Navigator.pop(context);

                                },
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  ) ,
                  onTap: () { //リストの一つ一つをタッチできるようになる
                    //確認画面に遷移
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(snapshot.data!.docs[index]))); //ToDO Navigator.push⇨押したら画面遷移

                  },
                );//実際に表示する内容を司る
              },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage()));

        },
        tooltip: 'Increment',
        child:  Icon(Icons.add),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
