part of 'version_cubit.dart';

final class VersionCubitState extends Equatable {
  const VersionCubitState({
    this.version,
    this.buildNumber,
  });

  final String? version;
  final String? buildNumber;

  VersionCubitState copyWith({
    String? version,
    String? buildNumber,
  }) {
    return VersionCubitState(
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }

  @override
  List<Object?> get props => [version, buildNumber];
}
