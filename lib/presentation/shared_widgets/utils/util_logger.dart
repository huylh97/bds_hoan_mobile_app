import 'dart:developer' as developer;
import 'package:logger/logger.dart';

class UtilLogger {
  static log([String tag = "LOGGER", dynamic msg]) {
    developer.log('${msg ?? ''}', name: tag);
  }

  static logInfo(String? message, {bool showBox = true}) {
    Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false, noBoxingByDefault: !showBox, lineLength: 50)).i(message, null, null);
  }

  static logError(
    String? message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    Logger().e(message, error, stackTrace);
  }

  ///Singleton factory
  static final _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
