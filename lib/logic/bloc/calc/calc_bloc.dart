import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:link_manager/app_logger.dart';

part 'calc_event.dart';
part 'calc_state.dart';
part 'calc_types.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(CalcInitial()) {
    on<CalcInit>(init);
    on<CalcAdd>(addEvent);
    // on<CalcSet>(set);
    // on<CalcRemove>(remove);
  }

  void init(CalcInit event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }

  // void set(CalcSet event, Emitter<CalcState> emit) {
  //   emit(CalcInitial());
  // }

  void addEvent(CalcAdd event, Emitter<CalcState> emit) async {
    if (this.state is! CalcInitial) {
      AppLogger.logError('Плохой стейт для добавления');
      return;
    }

    final state = this.state as CalcInitial;
    
    
    emit(state.copyWith(
      grades: [...state.grades, event.value],
    ));
  }

  // void remove(CalcRemove event, Emitter<CalcState> emit) {
  //   emit(CalcInitial());
  // }
}
