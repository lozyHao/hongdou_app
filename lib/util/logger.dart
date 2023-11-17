import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

late Logger logger;

class ClassicalPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [
      '[${event.time}][${_colorizeLevel(event.level)}][$caller]: ${event.message}'
    ];
  }

  String get caller {
    final trace = StackTrace.current.toString();
    final regExp = RegExp(r'\(package:hongdou_app(?:[^)]+\))');
    final caller = regExp.allMatches(trace).last.group(0) ?? 'unknown';
    return caller.split('/').last.replaceAll(')', '');
  }

  String _colorizeLevel(Level level) {
    Map<Level, int> ansiEscapeCodes = {
      Level.debug: 34,
      Level.error: 31,
      Level.info: 30,
      Level.warning: 33,
      Level.wtf: 35,
      Level.verbose: 36,
    };
    final shortLevel = level.toString().split('.').last;
    return '\u{1B}[${ansiEscapeCodes[level]}m$shortLevel\u{1B}[0m';
  }
}

class AlwaysLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !(kReleaseMode && event.level == Level.debug);
  }
}

/// Writes the log output to a single file name like `hongdou_app.$yyyy-$mm-$dd.log`.
class DatedFileOutput extends LogOutput {
  late File _file;

  @override
  Future<void> init() async {
    final now = DateTime.now().toString().substring(0, 10).replaceAll('/', '-');
    final directory = await getApplicationDocumentsDirectory();
    final logDirectory = Directory('${directory.path}/log');
    if (!logDirectory.existsSync()) {
      logDirectory.createSync();
    }
    _file = File('${logDirectory.path}/hongdou_app.$now.log');
    if (!_file.existsSync()) {
      _file.createSync();
    }
  }

  @override
  void output(OutputEvent event) async {
    final plain = event.lines.map(
      (line) => line.replaceAll(RegExp('\u001b\\[[;\\d]*m'), ''),
    );
    final content = await _file.readAsString();
    _file.writeAsString('${plain.join('\n')}\n$content');
  }
}

class LoggerInitializer {
  static void ensureInitialized() {
    logger = Logger(
      filter: AlwaysLogFilter(),
      output: MultiOutput([ConsoleOutput(), DatedFileOutput()]),
      printer: ClassicalPrinter(),
    );
  }
}
