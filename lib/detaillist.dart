import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ganhuo/bean/xddetail.dart';



class DetailList extends StatefulWidget{
  String detailId;
  String title;


  DetailList(this.detailId, this.title);

  @override
  State<StatefulWidget> createState() {
    return DetailListState();
  }
}
class DetailListState extends State<DetailList>{
  List<XdDetail> _details=[];
  @override
  void initState() {
    super.initState();
    getDetaillist();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: new Text(widget.title),),body: new ListView.builder(itemBuilder: (context,i){
      return new Column(children: <Widget>[
        Stack(children: <Widget>[
          CoverImage(_details[i].cover),
          new Positioned(child: new Container(child: new Text(_details[i].title,
            style: TextStyle(color: Colors.white,fontSize: 18.0,),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,),
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(color: const Color(0x80000000)),) ,bottom: 0.0,left: 0.0,right: 0.0,),
        ],)
      ],);
    },itemCount: _details.length,),);
  }
  Future getDetaillist()async {
    var url="http://gank.io/api/xiandu/data/id/${widget.detailId}/count/10/page/1";
    Dio dio = new Dio();
    Response response=await dio.get(url);
    Map<String, dynamic>  jsonResult = response.data;
    if(!jsonResult["error"]){
      List data = jsonResult["results"];
      List<XdDetail> result=[];
      for(var i=0;i<data.length;i++){
        result.add(XdDetail.fromJson(data[i]));
      }
      setState(() {
        _details=result;
      });
    }

  }


}

class CoverImage extends StatefulWidget{
  String _url;
  String _placeUrl="";

  CoverImage(this._url);

  @override
  State<StatefulWidget> createState() {
    return CoverImageState();
  }

}
class CoverImageState extends State<CoverImage>{
  String _placeUrl="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget._url==null||widget._url==""||widget._url=="none"){
      if(_placeUrl==""){
        getRadompic();
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget._url!=null&&widget._url!=""&&widget._url!="none"){
         return new Image.network(widget._url,height: 200.0,width: double.maxFinite,fit: BoxFit.fill,);
    }else{
      return new Image.network(_placeUrl,height: 200.0,width: double.maxFinite,fit: BoxFit.fill,);
    }
  }
  /**
   * 随机获取一张妹子图片
   */
  Future getRadompic()async {
    String picUrl="http://gank.io/api/random/data/福利/1";
    Dio dio = new Dio();
    Response response=await dio.get(picUrl);
    Map<String, dynamic>  jsonResult = response.data;
    if(!jsonResult["error"]){
      String pic=jsonResult["results"][0]["url"];
      setState(() {
        _placeUrl=pic;
      });
    }
  }

}




