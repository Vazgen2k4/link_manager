part of 'calc_bloc.dart';

sealed class CalcState extends Equatable {
  const CalcState();

  @override
  List<Object> get props => [];
}

final class CalcInitial extends CalcState {
  final List<CalcWeightedGrade> grades;
  final double awg;
  final double weightedAwg;

  const CalcInitial({
    this.awg = 0,
    this.weightedAwg = 0,
    this.grades = const [],
  });

  CalcInitial copyWith({
    List<CalcWeightedGrade>? grades,
    double? awg,
    double? weightedAwg,
  }) {
    return CalcInitial(
      grades: grades ?? this.grades,
      awg: awg ?? this.awg,
      weightedAwg: weightedAwg ?? this.weightedAwg,
    );
  }

  double calcAwg() {
    double sum = grades.map((e) => e.grade.value).reduce((v, e) => v + e);
    return sum / grades.length;
  }

  double calcWeighted() {
    final sum =
        grades.map((e) => e.grade.value * e.credit).reduce((v, e) => v + e);

    final weightSum = grades.map((e) => e.credit).reduce((v, e) => v + e);

    return sum / weightSum;
  }

  double sumWeightGrades() {
    return grades
        .map((e) => e.credit * (4 - e.grade.value))
        .reduce((v, e) => v + e);
  }

  @override
  List<Object> get props => [grades, awg, weightedAwg];
}
