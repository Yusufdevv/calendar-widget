import 'package:calendar_widget/core/exceptions/failures.dart';
import 'package:calendar_widget/core/usecase/usecase.dart';
import 'package:calendar_widget/core/utils/either.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:calendar_widget/feature/calendar/data/repository/calendar_repository_implemation.dart';
import 'package:calendar_widget/feature/calendar/domain/repository/calendar_repository.dart';

class GetTypesDataUseCase extends UseCase<List<TypeModel>, NoParams> {
  final CalendarRepository repository = CalendarRepositoryImplemation();
  @override
  Future<Either<Failure, List<TypeModel>>> call(NoParams params) async {
    return await repository.getTypesData();
  }
}
