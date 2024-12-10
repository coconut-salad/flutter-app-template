import "dart:io";

import "package:intl/intl.dart";
import "package:logger/logger.dart";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart";

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    output: MultiOutput([
      ConsoleOutput(),
      FileOutput(),
    ]),
  );

  static final AppLogger _instance = AppLogger._internal();

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal();

  static Level _logLevel = Level.all;

  static Level get logLevel => _logLevel;
  static set logLevel(Level level) {
    _logLevel = level;
    Logger.level = level;
  }

  void trace(String message) => _logger.t(message);
  void debug(String message) => _logger.d(message);
  void info(String message) => _logger.i(message);
  void warn(String message) => _logger.w(message);
  void error(String message, {Object? error}) =>
      _logger.e(message, error: error);
  void fatal(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}

class FileOutput extends LogOutput {
  static const int maxLogFiles = 100;
  static const int maxFileSizeBytes = 500 * 1024 * 1024; // 500MB

  @override
  Future<void> output(OutputEvent event) async {
    final directory = await getApplicationDocumentsDirectory();
    final logDirectory = Directory("${directory.path}/logs");

    if (!await logDirectory.exists()) {
      await logDirectory.create();
    }

    final today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final logFile = File("${logDirectory.path}/app_$today.log");

    // Rotate logs if file is too large
    if (await logFile.exists()) {
      final size = await logFile.length();
      if (size > maxFileSizeBytes) {
        await _rotateLogFiles(logDirectory);
      }
    }

    final timestamp = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now());
    final logEntry = event.lines.map((line) => "[$timestamp] $line").join("\n");

    await logFile.writeAsString(
      "$logEntry\n",
      mode: FileMode.append,
    );
  }

  Future<void> _rotateLogFiles(Directory logDirectory) async {
    final files = await logDirectory
        .list()
        .where((entity) => entity.path.endsWith(".log"))
        .toList();

    files.sort((a, b) => b.path.compareTo(a.path));

    // Delete oldest files if we exceed maxLogFiles
    if (files.length >= maxLogFiles) {
      for (var i = maxLogFiles - 1; i < files.length; i++) {
        await files[i].delete();
      }
    }

    // Rename existing files
    for (var i = files.length - 1; i >= 0; i--) {
      final file = File(files[i].path);
      final newPath = "${file.parent.path}/${path.basenameWithoutExtension(file.path)}_$i.log";
      await file.rename(newPath);
    }
  }
}

class MultiOutput extends LogOutput {
  final List<LogOutput> outputs;

  MultiOutput(this.outputs);

  @override
  void output(OutputEvent event) {
    for (var output in outputs) {
      output.output(event);
    }
  }
}
