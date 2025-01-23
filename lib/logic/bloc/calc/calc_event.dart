part of 'calc_bloc.dart';

sealed class CalcEvent extends Equatable {
  const CalcEvent();

  @override
  List<Object> get props => [];
}

final class CalcInit extends CalcEvent {}

final class CalcSet extends CalcEvent {
  final CalcGrades value;
  const CalcSet(this.value);

  @override
  List<Object> get props => [value];
}

final class CalcAdd extends CalcEvent {
  final CalcGrades value;
  const CalcAdd(this.value);

  @override
  List<Object> get props => [value];
}

final class CalcRemove extends CalcEvent {
  final int value;
  const CalcRemove(this.value);

  @override
  List<Object> get props => [value];
}
