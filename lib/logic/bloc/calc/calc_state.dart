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

  int sumCredits() {
    final grades = _getFilteredGrades();
    if (grades.isEmpty) {
      return 0;
    }
    return grades.map((e) => e.credit).reduce((v, e) => v + e);
  }

  double calcAwg() {
    final grades = _getFilteredGrades();

    if (grades.isEmpty) {
      return 0;
    }

    double sum = grades.map((e) => e.grade.value).reduce((v, e) => v + e);
    return sum / grades.length;
  }

  double calcWeightedAvg() {
    final grades = _getFilteredGrades();

    if (grades.isEmpty) {
      return 0;
    }
    final sum =
        grades.map((e) => e.grade.value * e.credit).reduce((v, e) => v + e);

    final weightSum = grades.map((e) => e.credit).reduce((v, e) => v + e);

    if (weightSum == 0) {
      return 0;
    }

    return sum / weightSum;
  }

  double sumWeightGrades() {
    final grades = _getFilteredGrades();
    if (grades.isEmpty) {
      return 0;
    }
    return grades
        .map((e) => e.credit * (4 - e.grade.value))
        .reduce((v, e) => v + e);
  }

  List<CalcWeightedGrade> _getFilteredGrades() {
    return grades.where((element) => element.grade != CalcGrade.none).toList();
  }

  @override
  List<Object> get props => [grades, awg, weightedAwg];
}
