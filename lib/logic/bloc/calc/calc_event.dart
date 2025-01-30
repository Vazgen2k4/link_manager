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
  const CalcAdd.none() : value = const CalcWeightedGrade(CalcGrade.none, 0.0);

  @override
  List<Object> get props => [value];
}
