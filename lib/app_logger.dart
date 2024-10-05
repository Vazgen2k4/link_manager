import 'dart:developer';

sealed class AppLogger {
  static void logHint(String value) {
    log('💡 HINT: $value', level: 500, name: 'HintLog');
  }

  static void logInfo(String value) {
    log('ℹ️ INFO: $value', level: 800, name: 'InfoLog');
  }

  static void logWarning(String value) {
    log('⚠️ WARNING: $value', level: 900, name: 'WarningLog');
  }

  static void logError(String value) {
    log('❌ ERROR: $value', level: 1000, name: 'ErrorLog');
  }

  static void logCritical(String value) {
    log('🔥 CRITICAL: $value', level: 1200, name: 'CriticalLog');
  }
}
