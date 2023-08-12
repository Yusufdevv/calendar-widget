class DayModel {
  final int day;
  final int type;

  DayModel({
    required this.day,
    required this.type,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
        day: json["day"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "type": type,
      };
}
