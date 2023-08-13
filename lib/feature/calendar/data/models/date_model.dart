import 'package:calendar_widget/feature/calendar/data/models/day_model.dart';

class DateModel {
  final int month;
  final int year;
  final List<DayModel> days;

  DateModel({
    required this.month,
    required this.year,
    required this.days,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        month: int.parse(json["month"] as String),
        year: json["year"],
        days: List<DayModel>.from(json["days"].map((x) => DayModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "days": List<DayModel>.from(days.map((x) => x.toJson())),
      };
}
