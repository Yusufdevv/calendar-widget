import 'package:calendar_widget/core/exceptions/failures.dart';
import 'package:calendar_widget/core/usecase/usecase.dart';
import 'package:calendar_widget/feature/calendar/data/models/date_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:calendar_widget/feature/calendar/domain/usecases/get_month_data_usecase.dart';
import 'package:calendar_widget/feature/calendar/domain/usecases/get_types_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetMonthDataUseCase _getMonthDataUseCase = GetMonthDataUseCase();
  final GetTypesDataUseCase _getTypesDataUseCase = GetTypesDataUseCase();
  CalendarBloc() : super(CalendarState(status: CalendarStatus.initial)) {
    on<GetMonthDataEvent>((event, emit) async {
      emit(state.copyWith(status: CalendarStatus.loading));
      final result = await _getMonthDataUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(status: CalendarStatus.success, date: result.right));
      } else {
        final failure = result.left;
        if (failure is ServerFailure) {
          emit(state.copyWith(status: CalendarStatus.loading));
        } else if (failure is DioFailure) {
          emit(state.copyWith(status: CalendarStatus.loading));
        } else {
          emit(state.copyWith(status: CalendarStatus.loading));
        }
      }
    });

    on<GetTypesDataEvent>((event, emit) async {
      emit(state.copyWith(status: CalendarStatus.loading));
      final result = await _getTypesDataUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(status: CalendarStatus.success, types: result.right));
      } else {
        final failure = result.left;
        if (failure is ServerFailure) {
          emit(state.copyWith(status: CalendarStatus.loading));
        } else if (failure is DioFailure) {
          emit(state.copyWith(status: CalendarStatus.loading));
        } else {
          emit(state.copyWith(status: CalendarStatus.loading));
        }
      }
    });
  }
}
