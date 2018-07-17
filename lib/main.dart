import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ganhuo/bean/menuitem.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_ganhuo/utils/NetUtils.dart';

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
        child: new Column(children: <Widget>[
          DrawerHeader(
            child:new Image.network("http://s6.51cto.com/wyfs02/M00/5C/96/wKiom1Ud68XRO27VAAGBrhfA-0g392.jpg",),
            margin: const EdgeInsets.only(bottom: 0.0),
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(color: Colors.white),
          )
          ,new MenuListView()
        ],)
        //new MenuListView(),


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
    print("请求菜单信息------");
    getMenuInfo();

  }
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _menus.length,
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemBuilder: (context, i){
        print("$i===${i.isOdd}");
        return new Column(children: <Widget>[
          new MenuListTile(_menus[i]),
          new Divider(height: 2.0)
        ],);
        //return new MenuListTile(_menus[i]);
    });
  }

  Future getMenuInfo()async {
      var url="http://gank.io/api/xiandu/categories";
    Dio dio = new Dio();
    Response response=await dio.get(url);
      Map<String, dynamic>  jsonResult = response.data;
      if(!jsonResult["error"]){
        List data = jsonResult["results"];
        List<MenuItem> result=[];
        for(var i=0;i<data.length;i++){
          result.add(MenuItem.fromJson(data[i]));
        }
        print(_menus.toString());
        setState(() {
          _menus=result;
        });

      }





  }


}
class MenuListTile extends StatefulWidget{
  MenuItem menuItem;

  MenuListTile(this.menuItem);

  @override
  State<StatefulWidget> createState() {
    return new MenuTileState(menuItem);
  }
}
class MenuTileState extends State<MenuListTile>{
  MenuItem menuItem;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  MenuTileState(MenuItem menuItem){
    this.menuItem=menuItem;
  }

  @override
  Widget build(BuildContext context) {
    return new  ListTile(
      title: new Text(
        menuItem.name,
        textAlign: TextAlign.center,
        style: _biggerFont,
      ),
    );
  }

}
