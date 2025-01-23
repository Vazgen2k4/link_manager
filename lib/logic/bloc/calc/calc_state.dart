part of 'calc_bloc.dart';

sealed class CalcState extends Equatable {
  const CalcState();

  static const Map<String, double> weights = {
    'A': 1.0,
    'B': 1.5,
    'C': 2.0,
    'D': 2.5,
    'E': 3.0,
    'F': 4.0,
  };

  @override
  List<Object> get props => [];
}

final class CalcInitial extends CalcState {
  final List<CalcGrades> grades;
  final double awg;
  final double weightedAwg;

  const CalcInitial({
    this.awg = 0,
    this.weightedAwg = 0,
    this.grades = const [],
  });

  CalcInitial copyWith({
    List<CalcGrades>? grades,
    double? awg,
    double? weightedAwg,
  }) {
    return CalcInitial(
      grades: grades ?? this.grades,
      awg: awg ?? this.awg,
      weightedAwg: weightedAwg ?? this.weightedAwg,
    );
  }

  @override
  List<Object> get props => [grades, awg, weightedAwg];
}

class CalcGrades {
  final String letter;
  final double credits;
  final double value;

  const CalcGrades({
    required this.letter,
    required this.value,
    required this.credits,
  });
}
