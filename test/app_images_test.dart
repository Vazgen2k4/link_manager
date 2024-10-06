import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:link_manager/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.cz).existsSync(), isTrue);
    expect(File(AppImages.en).existsSync(), isTrue);
    expect(File(AppImages.ru).existsSync(), isTrue);
  });
}
