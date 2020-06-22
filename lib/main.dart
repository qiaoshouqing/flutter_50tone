import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'MainAppBar.dart';
import 'Tone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const int _bluePrimaryValue = 0xFF0C28F8;
  MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(_bluePrimaryValue),
      100: Color(_bluePrimaryValue),
      200: Color(_bluePrimaryValue),
      300: Color(_bluePrimaryValue),
      400: Color(_bluePrimaryValue),
      500: Color(_bluePrimaryValue),
      600: Color(_bluePrimaryValue),
      700: Color(_bluePrimaryValue),
      800: Color(_bluePrimaryValue),
      900: Color(_bluePrimaryValue),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '50音图'),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        platform: TargetPlatform.iOS,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: MediaQuery.of(context).platformBrightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          appBar: new MainAppBar(),
          body: new Container(
            child: ListView(
              children: <Widget>[
                new Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: new Center(
                      child: new Text("清音（50音）",
                          style: new TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //一行的Widget数量
                  crossAxisCount: 5,
//                  childAspectRatio: 8 / 10,
                  childAspectRatio: 1,
                  //子Widget列表
                  padding: EdgeInsets.all(20),
                  children: _getWidgetList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getWidgetList() {
    List toneList = [
      Tone("a", "あ", "ア"),
      Tone("i", "い", "イ"),
      Tone("u", "う", "ウ"),
      Tone("e", "え", "エ"),
      Tone("o", "お", "オ"),
      Tone("ka", "か", "カ"),
      Tone("ki", "き", "キ"),
      Tone("ku", "く", "ク"),
      Tone("ke", "け", "ケ"),
      Tone("ko", "こ", "コ"),
      Tone("sa", "さ", "サ"),
      Tone("shi", "し", "シ"),
      Tone("su", "す", "ス"),
      Tone("se", "せ", "セ"),
      Tone("so", "そ", "ソ"),
      Tone("ta", "た", "タ"),
      Tone("chi", "ち", "チ"),
      Tone("tsu", "つ", "ツ"),
      Tone("te", "て", "テ"),
      Tone("to", "と", "ト"),
      Tone("na", "な", "ナ"),
      Tone("ni", "に", "ニ"),
      Tone("nu", "ぬ", "ヌ"),
      Tone("ne", "ね", "ネ"),
      Tone("no", "の", "ノ"),
      Tone("ha", "は", "ハ"),
      Tone("hi", "ひ", "ヒ"),
      Tone("fu", "ふ", "フ"),
      Tone("he", "へ", "ヘ"),
      Tone("ho", "ほ", "ホ"),
      Tone("ma", "ま", "マ"),
      Tone("mi", "み", "ミ"),
      Tone("mu", "む", "ム"),
      Tone("me", "め", "メ"),
      Tone("mo", "も", "モ"),
      Tone("ya", "や", "ヤ"),
      Tone("", "", ""),
      Tone("yu", "ゆ", "ユ"),
      Tone("", "", ""),
      Tone("yo", "よ", "ヨ"),
      Tone("ra", "ら", "ラ"),
      Tone("ri", "り", "リ"),
      Tone("ru", "る", "ル"),
      Tone("re", "れ", "レ"),
      Tone("ro", "ろ", "ロ"),
      Tone("wa", "わ", "ワ"),
      Tone("", "", ""),
      Tone("", "", ""),
      Tone("", "", ""),
      Tone("wo", "を", "ヲ"),
    ];

    List<Widget> widgets = [];
    for (int i = 0; i < toneList.length; i++) {
      widgets.add(_getSingleWidget(toneList[i]));
    }
    return widgets;
  }

  AudioCache sucessCachePlayer = new AudioCache();

  _getSingleWidget(Tone tone) {
    return new InkWell(
//      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if(tone.roman != null && tone.roman != "") {
          await sucessCachePlayer.play("audio/" + tone.roman + ".mp3");
        }
      },
      child: new Container(
//        alignment: Alignment.center,
//        child: new Column(
//          children: <Widget>[
//            new Container(
//              child: new Text(tone.hiragana,
//                  style: new TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  )),
//            ),
//            new Container(
//              child: new Text(tone.katakana,
//                  style: new TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.grey[500],
//                  )),
//            ),
//            new Container(
//              child: new Text(tone.roman),
//            ),
//          ],
//        ),
        child: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    child: new Text(tone.hiragana,
                        style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  new Container(
                    width: 5,
                  ),
                  new Container(
                    child: new Text(tone.katakana,
                        style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        )),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              new Container(
                alignment: Alignment.center,
                child: new Text(tone.roman),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
