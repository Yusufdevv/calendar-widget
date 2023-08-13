import 'package:calendar_widget/core/exceptions/exceptions.dart';
import 'package:calendar_widget/feature/calendar/data/models/date_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:dio/dio.dart';

abstract class CalendarDataSource {
  Future<DateModel> getMonthData();
  Future<List<TypeModel>> getTypesData();
}

class CalendarDataSourceImplemation extends CalendarDataSource {
  final dio = Dio();
  @override
  Future<DateModel> getMonthData() async {
    try {
      final response = await dio.get('https://jsonkeeper.com/b/92TT');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return DateModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw ServerException(statusCode: response.statusCode ?? 0, errorMessage: response.statusMessage ?? '');
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<TypeModel>> getTypesData() async {
    try {
      final response = await dio.get('https://www.jsonkeeper.com/b/I86U');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<TypeModel> myList = (response.data as List).map((jsonElement) => TypeModel.fromJson(jsonElement)).toList();

        return myList;
      }
      throw ServerException(statusCode: response.statusCode ?? 0, errorMessage: response.statusMessage ?? '');
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
