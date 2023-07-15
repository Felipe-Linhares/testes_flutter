import 'dart:convert';

class AutoCompletarModel {
  String? _id;
  int? _createdAt;
  String? _name;
  String? _imageUrl;
  dynamic _posts;

  AutoCompletarModel({id, name, createdAt, imageUrl, posts}) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _imageUrl = imageUrl;
    _posts = posts;
  }

  String get id => _id ?? '0';
  set id(String? valor) {
    _id = valor ?? '0';
  }

  String get name => _name ?? '';
  set name(String? valor) {
    _name = valor ?? '';
  }

  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? valor) {
    _imageUrl = valor ?? '';
  }

  dynamic get posts => _posts ?? [];
  set posts(dynamic valor) {
    _posts = valor ?? [];
  }

  int get createdAt => _createdAt ?? 0;
  set createdAt(int? valor) {
    _createdAt = valor ?? 0;
  }

  factory AutoCompletarModel.fromJson(Map<String, dynamic> json,
      {bool useUtf8 = true}) {
    return AutoCompletarModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      imageUrl: json['imageUrl'],
      posts: json['posts'],
    );
  }

  toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
      'posts': posts,
    });
  }
}
