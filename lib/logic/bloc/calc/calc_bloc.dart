import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(CalcInitial()) {
    on<CalcInit>(init);
    on<CalcSet>(set);
    on<CalcAdd>(addEvent);
    on<CalcRemove>(remove);
  }

  void init(CalcInit event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }

  void set(CalcSet event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }

  void addEvent(CalcAdd event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }

  void remove(CalcRemove event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }
}
