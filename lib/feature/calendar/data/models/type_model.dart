import 'dart:convert';

List<TypeModel> typeModelFromJson(String str) =>
    List<TypeModel>.from(json.decode(str).map((x) => TypeModel.fromJson(x)));

class TypeModel {
  final int type;
  final String color;

  TypeModel({
    required this.type,
    required this.color,
  });

  TypeModel copyWith({
    int? type,
    String? color,
  }) =>
      TypeModel(
        type: type ?? this.type,
        color: color ?? this.color,
      );

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        type: json["type"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "color": color,
      };
}
