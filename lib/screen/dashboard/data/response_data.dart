import 'dart:convert';

ResponseData responseDataFromJson(String str) =>
    ResponseData.fromJson(json.decode(str));
String responseDataToJson(ResponseData data) => json.encode(data.toJson());

class ResponseData {
  ResponseData({
    String? createdAt,
    String? title,
    String? description,
    String? updatedAt,
    String? color,
    bool? pinned,
    bool? isCompleted,
    String? userId,
    String? id,
  }) {
    _createdAt = createdAt;
    _title = title;
    _description = description;
    _updatedAt = updatedAt;
    _color = color;
    _pinned = pinned;
    _isCompleted = isCompleted;
    _userId = userId;
    _id = id;
  }

  ResponseData.fromJson(dynamic json) {
    _createdAt = json['createdAt'];
    _title = json['title'];
    _description = json['description'];
    _updatedAt = json['updatedAt'];
    _color = json['color'];
    _pinned = json['pinned'];
    _isCompleted = json['isCompleted'];
    _userId = json['userId'];
    _id = json['id'];
  }
  String? _createdAt;
  String? _title;
  String? _description;
  String? _updatedAt;
  String? _color;
  bool? _pinned;
  bool? _isCompleted;
  String? _userId;
  String? _id;
  ResponseData copyWith({
    String? createdAt,
    String? title,
    String? description,
    String? updatedAt,
    String? color,
    bool? pinned,
    bool? isCompleted,
    String? userId,
    String? id,
  }) =>
      ResponseData(
        createdAt: createdAt ?? _createdAt,
        title: title ?? _title,
        description: description ?? _description,
        updatedAt: updatedAt ?? _updatedAt,
        color: color ?? _color,
        pinned: pinned ?? _pinned,
        isCompleted: isCompleted ?? _isCompleted,
        userId: userId ?? _userId,
        id: id ?? _id,
      );
  String? get createdAt => _createdAt;
  String? get title => _title;
  String? get description => _description;
  String? get updatedAt => _updatedAt;
  String? get color => _color;
  bool? get pinned => _pinned;
  bool? get isCompleted => _isCompleted;
  String? get userId => _userId;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = _createdAt;
    map['title'] = _title;
    map['description'] = _description;
    map['updatedAt'] = _updatedAt;
    map['color'] = _color;
    map['pinned'] = _pinned;
    map['isCompleted'] = _isCompleted;
    map['userId'] = _userId;
    map['id'] = _id;
    return map;
  }
}
