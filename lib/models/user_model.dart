import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool? status;
  final String? message;
  final _UserData? data;

  const UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? _UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data};
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  List<Object> get props => [
        status ?? false,
        message ?? "Not found message",
        data ?? "Not found data",
      ];
}

class _UserData extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String phone;
  final String image;
  final String token;

  const _UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    required this.token,
  });

  factory _UserData.fromJson(Map<String, dynamic> json) {
    return _UserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      password ?? "",
      phone,
      image,
      token,
    ];
  }
}
