import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'version_state.dart';

class VersionCubit extends Cubit<VersionCubitState> {
  VersionCubit() : super(VersionCubitState()) {
    _init();
  }

  Future<void> _init() async {
    final info = await PackageInfo.fromPlatform();

    emit(state.copyWith(
      version: info.version,
      buildNumber: info.buildNumber,
    ));
  }
}
