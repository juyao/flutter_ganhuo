import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ganhuo/bean/menuitem.dart';
import 'package:flutter_ganhuo/bean/xdcategorytype.dart';

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
      home: new MyHomePage(title: '闲读'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements MenuClicklistener{
  List<MenuItem> _menus;
  List<XdCategoryType> _types;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menus=List<MenuItem>();
    _types=List<XdCategoryType>();
    getMenuInfo();
  }
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
            //child:new Image.network("https://desk-fd.zol-img.com.cn/t_s2880x1800c5/g5/M00/0F/07/ChMkJlauy1qIdJC1AEohbxroTTQAAH81AG-LL8ASiGH977.jpg",)
           //child: new Container(color: Colors.red,child: new Image.network("https://desk-fd.zol-img.com.cn/t_s2880x1800c5/g5/M00/0F/07/ChMkJlauy1qIdJC1AEohbxroTTQAAH81AG-LL8ASiGH977.jpg",),)
            margin: const EdgeInsets.only(bottom: 0.0),
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(color: Colors.white,
                image:new DecorationImage(image: NetworkImage("https://desk-fd.zol-img.com.cn/t_s2880x1800c5/g5/M00/0F/07/ChMkJlauy1qIdJC1AEohbxroTTQAAH81AG-LL8ASiGH977.jpg"))),
          )
          ,new MenuListView(_menus,this)
        ],)
        //new MenuListView(),


      ),
      body: TypeListView(_types),
    );
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
      if(result.length>0){
        getTypeInfo(result[0].enName);
      }
      print(_menus.toString());
      setState(() {
        _menus=result;
      });
    }
  }
  Future getTypeInfo(String menu)async {
    var typeUrl="http://gank.io/api/xiandu/category/$menu";
    Dio dio = new Dio();
    Response response=await dio.get(typeUrl);
    Map<String, dynamic>  jsonResult = response.data;
    if(!jsonResult["error"]){
      List data = jsonResult["results"];
      List<XdCategoryType> result=[];
      for(var i=0;i<data.length;i++){
        result.add(XdCategoryType.fromJson(data[i]));
      }
      setState(() {
        _types=result;
      });

    }
  }

  @override
  void click(int position) {
    getTypeInfo(_menus[position].enName);

  }
}
class MenuListView extends StatelessWidget{
  List<MenuItem> _menus;
  MenuClicklistener clicklistener;
  MenuListView(this._menus, this.clicklistener);
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: _menus.length,
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemBuilder: (context, i){
          print("$i===${i.isOdd}");
          return new Column(children: <Widget>[
            new  ListTile(
              title: new Text(
                _menus[i].name,
                textAlign: TextAlign.center,
                style: _biggerFont,
              ),
              onTap:(){
                if(null!=clicklistener){
                  clicklistener.click(i);
                }
                Navigator.pop(context);
              } ,
            ),
            new Divider(height: 2.0)
          ],);
          //return new MenuListTile(_menus[i]);
        });
  }
}
class TypeListView extends StatelessWidget{
  List<XdCategoryType> types;
  TypeListView(this.types);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context,i){
      return new Column(children: <Widget>[
        ListTile(leading: new Image.network(types[i].icon),
          title: Text(types[i].title),),
        new Divider(height: 2.0)
      ],);
    },itemCount: types.length,);
  }
}

abstract class MenuClicklistener {
  void click(int position); // 这是一个抽象方法，不需要abstract关键字，是隐式接口的一部分。
}


