import 'dart:convert';

/// id : 8
/// username : "avat"
/// email : "ava.taylor@x.dummyjson.com"
/// firstName : "Ava"
/// lastName : "Taylor"
/// gender : "female"
/// image : "https://dummyjson.com/icon/avat/128"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJhdmF0IiwiZW1haWwiOiJhdmEudGF5bG9yQHguZHVtbXlqc29uLmNvbSIsImZpcnN0TmFtZSI6IkF2YSIsImxhc3ROYW1lIjoiVGF5bG9yIiwiZ2VuZGVyIjoiZmVtYWxlIiwiaW1hZ2UiOiJodHRwczovL2R1bW15anNvbi5jb20vaWNvbi9hdmF0LzEyOCIsImlhdCI6MTcyMDg1MjMwNSwiZXhwIjoxNzIwODU1OTA1fQ.YV1mWLxYmN4nPlJO9YHzwEWbPrz8B0KvKVY7wEb6U6I"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJhdmF0IiwiZW1haWwiOiJhdmEudGF5bG9yQHguZHVtbXlqc29uLmNvbSIsImZpcnN0TmFtZSI6IkF2YSIsImxhc3ROYW1lIjoiVGF5bG9yIiwiZ2VuZGVyIjoiZmVtYWxlIiwiaW1hZ2UiOiJodHRwczovL2R1bW15anNvbi5jb20vaWNvbi9hdmF0LzEyOCIsImlhdCI6MTcyMDg1MjMwNSwiZXhwIjoxNzIzNDQ0MzA1fQ.H0eed2suOVCqYrBRRPftDiYVa-jULin9lMwrCbJJSjE"

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    num? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? token,
    String? refreshToken,
  }) {
    _id = id;
    _username = username;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _image = image;
    _token = token;
    _refreshToken = refreshToken;
  }

  LoginResponse.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _gender = json['gender'];
    _image = json['image'];
    _token = json['token'];
    _refreshToken = json['refreshToken'];
  }
  num? _id;
  String? _username;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _gender;
  String? _image;
  String? _token;
  String? _refreshToken;
  LoginResponse copyWith({
    num? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? token,
    String? refreshToken,
  }) =>
      LoginResponse(
        id: id ?? _id,
        username: username ?? _username,
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        gender: gender ?? _gender,
        image: image ?? _image,
        token: token ?? _token,
        refreshToken: refreshToken ?? _refreshToken,
      );
  num? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get gender => _gender;
  String? get image => _image;
  String? get token => _token;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['gender'] = _gender;
    map['image'] = _image;
    map['token'] = _token;
    map['refreshToken'] = _refreshToken;
    return map;
  }
}
