/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/util/log_util.dart
 * Created Date: 2021-08-21 17:08:35
 * Last Modified: 2021-09-04 11:38:36
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:logger/logger.dart';

class CustomPrinter extends LogPrinter {
  final LogPrinter _realPrinter;
  late Map<Level, String> _prefixMap;

  CustomPrinter(
    this._realPrinter, {
    debug,
    verbose,
    wtf,
    info,
    warning,
    error,
    nothing,
  }) : super() {
    _prefixMap = {
      Level.debug: debug ?? 'DEBUG',
      Level.verbose: verbose ?? 'VERBOSE',
      Level.wtf: wtf ?? 'WTF',
      Level.info: info ?? 'INFO',
      Level.warning: warning ?? 'WARNING',
      Level.error: error ?? 'ERROR',
      Level.nothing: nothing ?? 'NOTHING',
    };
  }

  @override
  List<String> log(LogEvent event) {
    return _realPrinter
        .log(event)
        .map((s) => '${_prefixMap[event.level]}$s')
        .toList();
  }
}

final customLogger = Logger(
  printer: CustomPrinter(
    PrettyPrinter(
      colors: false,
    ),
  ),
);
