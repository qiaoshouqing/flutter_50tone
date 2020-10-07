import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter50tone/utils/ScreenUtil.dart';

import 'Constant.dart';
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
        primarySwatch: blue,
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
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          appBar: new MainAppBar(),
          body: new Stack(
            children: <Widget>[
              new Container(
                child: ListView(
                  children: <Widget>[
                    new Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: new Center(
                          child: new Text("清音（50音）",
                              style: new TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              )),
                        )),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //一行的Widget数量
                      crossAxisCount: 5,
                      //子Widget列表
                      padding: EdgeInsets.all(20),
                      children: _getWidgetList(),
                    ),
                  ],
                ),
              ),
              new Container(
                color: Colors.grey,
                width: ScreenUtil.getScreenWidth(),
                height: 30,
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: new Row(
                    children: <Widget>[
                      new Text("卡片"),
                      new Text("五十音"),
                      new Text("华容道"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getWidgetList() {
    List<Widget> widgets = [];
    for (int i = 0; i < Constant.toneList.length; i++) {
      widgets.add(_getSingleWidget(Constant.toneList[i]));
    }
    return widgets;
  }

  AudioCache sucessCachePlayer = new AudioCache();

  _getSingleWidget(Tone tone) {
    return new InkWell(
//      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (tone.roman != null && tone.roman != "") {
          await sucessCachePlayer.play("audio/" + tone.roman + ".mp3");
        }
      },
      child: new Container(
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
