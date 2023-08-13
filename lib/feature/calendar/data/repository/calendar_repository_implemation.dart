import 'package:calendar_widget/core/exceptions/exceptions.dart';
import 'package:calendar_widget/core/exceptions/failures.dart';
import 'package:calendar_widget/core/utils/either.dart';
import 'package:calendar_widget/feature/calendar/data/datasource/calendar_datasource.dart';
import 'package:calendar_widget/feature/calendar/data/models/date_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:calendar_widget/feature/calendar/domain/repository/calendar_repository.dart';
import 'package:dio/dio.dart';

class CalendarRepositoryImplemation extends CalendarRepository {
  final CalendarDataSource _dataSource = CalendarDataSourceImplemation();
  @override
  Future<Either<Failure, DateModel>> getMonthData() async {
    try {
      final result = await _dataSource.getMonthData();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on DioException {
      return Left(DioFailure());
    } on DioCustomException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<TypeModel>>> getTypesData() async {
    try {
      final result = await _dataSource.getTypesData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on DioException {
      return Left(DioFailure());
    } on DioCustomException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
