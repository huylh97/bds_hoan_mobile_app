// ignore_for_file: constant_identifier_names

import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:intl/intl.dart';

class UtilDateTime {
  static String formatDateTime(DateTime? dateTime, {String pattern = "dd/MM/yyyy"}) {
    if (dateTime == null) return '';
    return DateFormat(pattern).format(dateTime);
  }

  static String formatDateTimeToSubmit(DateTime? dateTime, {String pattern = "yyyy-MM-dd"}) {
    if (dateTime == null) return '';
    return DateFormat(pattern).format(dateTime);
  }

  static DateTime? stringToDateTime(String? value, {String pattern = "yyyy-MM-dd"}) {
    if (value == null) return null;
    try {
      return DateFormat(pattern).parse(value);
    } catch (e) {
      try {
        return DateFormat('yyyy-MM-dd hh:mm').parse(value);
      } catch (e) {
        UtilLogger.log("ERROR-stringToDateTime()", e);
        return null;
      }
    }
  }

  static DateTime? stringUtcToDateTimeLocal(String? value, {String pattern = "yyyy-MM-ddThh:mm:ss.000Z"}) {
    if (value == null) return null;
    try {
      final _tempDate = DateFormat(pattern).parse(value);
      final _utcTime = DateTime.utc(_tempDate.year, _tempDate.month, _tempDate.day, _tempDate.hour, _tempDate.minute, _tempDate.second);
      return _utcTime.toLocal();
    } catch (e) {
      try {
        final _tempDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(value);
        final _utcTime = DateTime.utc(_tempDate.year, _tempDate.month, _tempDate.day, _tempDate.hour, _tempDate.minute, _tempDate.second);

        return _utcTime.toLocal();
      } catch (e) {
        UtilLogger.log("ERROR-stringToDateTime()", e);
        return null;
      }
    }
  }

  static DateTime? stringUtcToDateTimeLocal1(String? value, {String pattern = "yyyy-MM-ddThh:mm:ss.000Z"}) {
    if (value == null) return null;
    try {
      final _tempDate = DateFormat(pattern).parse(value);
      final _utcTime = DateTime.utc(_tempDate.year, _tempDate.month, _tempDate.day, _tempDate.hour, _tempDate.minute, _tempDate.second);
      return _utcTime.toLocal();
    } catch (e) {
      try {
        final _tempDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(value);
        final _utcTime = DateTime.utc(_tempDate.year, _tempDate.month, _tempDate.day, _tempDate.hour, _tempDate.minute, _tempDate.second);
        return _utcTime.toLocal();
      } catch (e) {
        UtilLogger.log("ERROR-stringToDateTime()", e);
        return null;
      }
    }
  }

  ///Singleton factory
  static final _instance = UtilDateTime._internal();

  factory UtilDateTime() {
    return _instance;
  }

  UtilDateTime._internal();
}
