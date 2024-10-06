import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:link_manager/resources/resources.dart';

void main() {
  test('app_icons assets test', () {
    expect(File(AppIcons.logo).existsSync(), isTrue);
  });
}
