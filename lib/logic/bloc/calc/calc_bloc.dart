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
    on<CalcRemove>(remove);
    on<CalcSetGrade>(setGrade);
  }

  void init(CalcInit event, Emitter<CalcState> emit) {
    emit(CalcInitial());
  }

  void setGrade(CalcSetGrade event, Emitter<CalcState> emit) {
    if (event.index < 0) {
      AppLogger.logError('Индекс меньше нуля');
      return;
    }

    if (this.state is! CalcInitial) {
      AppLogger.logError('Плохой стейт для добавления');
      return;
    }

    final state = this.state as CalcInitial;

    if (event.index >= state.grades.length) {
      AppLogger.logError('Индекс больше длины списка');
      return;
    }

    final grade = event.grade;
    final grades = [...state.grades];
    grades[event.index] = grade;

    emit(state.copyWith(grades: grades));
  }

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

  void remove(CalcRemove event, Emitter<CalcState> emit) {
    if (event.index < 0) {
      AppLogger.logError('Индекс меньше нуля');
      return;
    }

    if (this.state is! CalcInitial) {
      AppLogger.logError('Плохой стейт для добавления');
      return;
    }

    final state = this.state as CalcInitial;

    if (event.index >= state.grades.length) {
      AppLogger.logError('Индекс больше длины списка');
      return;
    }

    final grades = [...state.grades];
    grades.removeAt(event.index);

    emit(state.copyWith(grades: grades));
  }
}
