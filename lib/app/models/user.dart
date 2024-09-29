import 'package:pocketbase/pocketbase.dart';
import 'package:beerenyi/app/services/pocketbase.dart';

class User {
  User({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.avatar,
    required this.email,
    required this.name,
    required this.username,
    this.token,
  });

  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  final String? avatar;
  final String? email;
  final String? name;
  final String? username;
  String? token;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      created: DateTime.tryParse(json["created"] ?? ""),
      updated: DateTime.tryParse(json["updated"] ?? ""),
      collectionId: json["collectionId"],
      collectionName: json["collectionName"],
      avatar: json["avatar"],
      email: json["email"],
      name: json["name"],
      username: json["username"],
    );
  }

  Uri? get getProfilePic => avatar?.isEmpty == true
      ? null
      : PocketbaseService.to.getFileUrl(
          RecordModel(
            id: id ?? "",
            collectionId: collectionId ?? "",
            collectionName: collectionName ?? "",
          ),
          avatar ?? "");
  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "collectionId": collectionId,
        "collectionName": collectionName,
        "avatar": avatar,
        "email": email,
        "name": name,
        "username": username,
        "token": token,
      };
}