import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String hashPassword() {
    return md5.convert(utf8.encode(this)).toString();
  }

  String formatDateTimeString() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('EEEE  d  MMM', 'ar');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String getDayFromTime() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('EEEE', 'ar');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
  //
  // String formatTimeString() {
  //   DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
  //   var inputDate = DateTime.parse(parseDate.toString());
  //   var outputFormat = DateFormat('EEEE  d  MMM', 'ar');
  //   var outputDate = outputFormat.format(inputDate);
  //   return outputDate;
  // }

  String getMonthYearTime() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM yyyy', 'ar');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String getTimeHoursNow() {
    return DateFormat.jm('ar').format(DateTime.now()).toString();
  }

  String getTimeHours() {
    return DateFormat.jm('ar').format(DateTime.parse(this)).toString();
  }
}
