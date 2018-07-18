class XdCategoryType {
  String _sId;
  String _createdAt;
  String _icon;
  String _id;
  String _title;

  XdCategoryType(
      {String sId, String createdAt, String icon, String id, String title}) {
    this._sId = sId;
    this._createdAt = createdAt;
    this._icon = icon;
    this._id = id;
    this._title = title;
  }

  String get sId => _sId;
  set sId(String sId) => _sId = sId;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get icon => _icon;
  set icon(String icon) => _icon = icon;
  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;

  XdCategoryType.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _createdAt = json['created_at'];
    _icon = json['icon'];
    _id = json['id'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['created_at'] = this._createdAt;
    data['icon'] = this._icon;
    data['id'] = this._id;
    data['title'] = this._title;
    return data;
  }
}

