// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstructorModel {
  String? name;
  String? id;

  InstructorModel({
    this.name,
    this.id,
  });

  InstructorModel copyWith({
    String? name,
    String? id,
  }) {
    return InstructorModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory InstructorModel.fromMap(Map<String, dynamic> map) {
    return InstructorModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorModel.fromJson(String source) =>
      InstructorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'InstructorModel(name: $name, id: $id)';

  @override
  bool operator ==(covariant InstructorModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
