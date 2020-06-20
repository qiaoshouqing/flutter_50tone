import 'package:flutter/material.dart';
import 'package:flutter50tone/utils/ScreenUtil.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainAppBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(0);

}

class MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container();
  }
}