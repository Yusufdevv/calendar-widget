import 'package:flutter_bloc/flutter_bloc.dart';
part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(DayInitial(DateTime.now(), 0)) {
    on<GetDayDataEvent>((event, emit) {
      emit(DayInitial(event.date, event.type));
      // onSuccess methodi state ga saqlangan data ni ui da ko'rsatish uchun qo'shilgan
      event.onSuccess(state.date, state.type);
    });
  }
}
