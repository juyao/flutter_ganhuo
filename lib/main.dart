import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ganhuo/bean/menuitem.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: '干货集中营'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      drawer: Drawer(
        child: new MenuListView(),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
class MenuListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MenuState();
  }

}
class _MenuState extends State<MenuListView>{
  List<MenuItem> _menus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menus=List<MenuItem>();
    getMenuInfo();

  }
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("test"),
    );
  }

  Future getMenuInfo()async {
    Dio dio = new Dio();
    Response menuResponse = await dio.get("http://gank.io/api/xiandu/categories");
    print(menuResponse.data);
  }


}
