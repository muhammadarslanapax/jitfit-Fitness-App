// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminwebModel {
  String? name;
  String? email;
  String? password;
  String? id;
  String? status;
  String? imageURL;
  bool? isOnline;
  String? lastActive;
  String? tokan;
  String? createdAt;
  AdminwebModel({
    this.name,
    this.email,
    this.password,
    this.id,
    this.status,
    this.imageURL,
    required this.isOnline,
    required this.lastActive,
    required this.tokan,
    required this.createdAt,
  });

  AdminwebModel copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? status,
    String? imageURL,
    bool? isOnline,
    String? lastActive,
    String? tokan,
    String? createdAt,
  }) {
    return AdminwebModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      status: status ?? this.status,
      imageURL: imageURL ?? this.imageURL,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      tokan: tokan ?? this.tokan,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'status': status,
      'imageURL': imageURL,
      'isOnline': isOnline,
      'lastActive': lastActive,
      'tokan': tokan,
      'createdAt': createdAt,
    };
  }

  factory AdminwebModel.fromMap(Map<String, dynamic> map) {
    return AdminwebModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      lastActive:
          map['lastActive'] != null ? map['lastActive'] as String : null,
      tokan: map['tokan'] != null ? map['tokan'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminwebModel.fromJson(String source) =>
      AdminwebModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminwebModel(name: $name, email: $email, password: $password, id: $id, status: $status, imageURL: $imageURL, isOnline: $isOnline, lastActive: $lastActive, tokan: $tokan, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant AdminwebModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.id == id &&
        other.status == status &&
        other.imageURL == imageURL &&
        other.isOnline == isOnline &&
        other.lastActive == lastActive &&
        other.tokan == tokan &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        id.hashCode ^
        status.hashCode ^
        imageURL.hashCode ^
        isOnline.hashCode ^
        lastActive.hashCode ^
        tokan.hashCode ^
        createdAt.hashCode;
  }
}
