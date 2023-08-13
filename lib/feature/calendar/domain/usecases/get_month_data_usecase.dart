import 'package:calendar_widget/core/exceptions/failures.dart';
import 'package:calendar_widget/core/usecase/usecase.dart';
import 'package:calendar_widget/core/utils/either.dart';
import 'package:calendar_widget/feature/calendar/data/models/date_model.dart';
import 'package:calendar_widget/feature/calendar/data/repository/calendar_repository_implemation.dart';
import 'package:calendar_widget/feature/calendar/domain/repository/calendar_repository.dart';

class GetMonthDataUseCase extends UseCase<DateModel, NoParams> {
  final CalendarRepository repository = CalendarRepositoryImplemation();
  @override
  Future<Either<Failure, DateModel>> call(NoParams params) async {
    return await repository.getMonthData();
  }
}
