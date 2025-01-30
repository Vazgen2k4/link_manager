part of 'calc_bloc.dart';

enum CalcGrade {
  A(1.0),
  B(1.5),
  C(2.0),
  D(2.5),
  E(3.0),
  F(4.0),
  none(0.0);

  final double value;

  const CalcGrade(this.value);
}

final class CalcWeightedGrade {
  final CalcGrade grade;
  final int credit;

  const CalcWeightedGrade(this.grade, this.credit);

  CalcWeightedGrade copyWith({
    CalcGrade? grade,
    int? credit,
  }) {
    return CalcWeightedGrade(
      grade ?? this.grade,
      credit ?? this.credit,
    );
  }
}

enum CalcType {
  awg,
  weightedAwg,
  sumGrades,
  sumWeightGrades
}
