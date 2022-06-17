import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/toppage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}


//todo アプリのタイトルを変更⇨toppageのappBarを変えた
//todo メモクラスを定義⇨新しくmemo用のdartファイルを開いてメモを作成するのに必要な変数を定義するこれは各自のオリジナルが出せる部分
//todo　Android Firebaseプロジェクトの作成⇨firebaseの指示に従ってkeyを入れ込んだり、追加するだけ、忘れたら動画見ればよい
//todo　ios FIrebaseプロジェクトの作成⇨iosは割と簡単、ユーザ直下のディレクトリにStudioprojectとして保存してある
//todo　Cloud Firestoreを設定⇨要はデータベースの設計ってことだと思う、titleとかdetailとかmemoクラスで作成した変数を使ってるけどまだよくわからない
//todo　FlutterとFirebaseを連携⇨dart packageをインストールして指示に従う。main関数で色々追加する。Firebaseの初期化
//todo　TopPageにメモのリストを表示
//todo　リストをタップでメモの詳細を確認可能に
//todo　メモ追加画面のUI作成
//todo　追加ボタンタップでメモを追加可能に
//todo　追加したメモをリアルタイム取得表示
//todo　リストの右側のボタンタップでボトムシートを表示
//todo　編集画面を作成しメモを更新可能に
//todo　メモを削除可能に

