import 'package:calendar_widget/core/exceptions/failures.dart';
import 'package:calendar_widget/core/utils/either.dart';
import 'package:calendar_widget/feature/calendar/data/models/date_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';

abstract class CalendarRepository {
  Future<Either<Failure, DateModel>> getMonthData();
  Future<Either<Failure, List<TypeModel>>> getTypesData();
}
