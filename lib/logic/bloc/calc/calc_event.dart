part of 'calc_bloc.dart';

sealed class CalcEvent extends Equatable {
  const CalcEvent();

  @override
  List<Object> get props => [];
}

final class CalcInit extends CalcEvent {
  const CalcInit();
}

final class Calculate extends CalcEvent {
  final List<CalcGrade> values;
  const Calculate(this.values);

  @override
  List<Object> get props => [values];
}

final class CalcAdd extends CalcEvent {
  final CalcWeightedGrade value;
  const CalcAdd(this.value);
  const CalcAdd.none() : value = const CalcWeightedGrade(CalcGrade.none, 0);

  @override
  List<Object> get props => [value];
}

final class CalcRemove extends CalcEvent {
  final int index;
  const CalcRemove(this.index);

  @override
  List<Object> get props => [index];
}

final class CalcSetGrade extends CalcEvent {
  final int index;
  final CalcWeightedGrade grade;
  const CalcSetGrade(this.index, this.grade);

  @override
  List<Object> get props => [index];
}
