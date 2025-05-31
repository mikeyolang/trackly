import 'dart:developer' as developer;

/// A utility class for printing styled log messages to the console.
///
/// Provides methods for printing different types of messages with color coding:
/// - Info: Blue
/// - Success: Green
/// - Warning: Yellow/Orange
/// - Error: Red
/// - Debug: Purple
class ConsoleLogger {
  static final ConsoleLogger _instance = ConsoleLogger._internal();

  factory ConsoleLogger() => _instance;
  ConsoleLogger._internal();

  /// ANSI color codes
  static const String _resetColor = '\x1B[0m';
  static const String _blueColor = '\x1B[34m';
  static const String _greenColor = '\x1B[32m';
  static const String _yellowColor = '\x1B[33m';
  static const String _redColor = '\x1B[31m';
  static const String _purpleColor = '\x1B[35m';
  static const String _cyanColor = '\x1B[36m';
  bool showTimestamp = true;
  bool showLogLevel = true;
  String get _timestamp => DateTime.now().toString();

  /// Prints an info message in blue
  void info(String text) {
    _printFormatted(_blueColor, 'INFO', text);
  }

  /// Prints a success message in green
  void success(String text) {
    _printFormatted(_greenColor, 'SUCCESS', text);
  }

  /// Prints a warning message in yellow
  void warning(String text) {
    _printFormatted(_yellowColor, 'WARNING', text);
  }

  /// Prints an error message in red
  void error(String text) {
    _printFormatted(_redColor, 'ERROR', text);
  }

  /// Prints a debug message in purple
  void debug(String text) {
    _printFormatted(_purpleColor, 'DEBUG', text);
  }

  /// Prints a network request message in cyan
  void network(String text) {
    _printFormatted(_cyanColor, 'NETWORK', text);
  }

  /// Helper method to format and print the log message
  void _printFormatted(String color, String level, String text) {
    String prefix = '';

    if (showTimestamp) {
      prefix += '[$_timestamp] ';
    }

    if (showLogLevel) {
      prefix += '[$level] ';
    }

    developer.log('$color$prefix$text$_resetColor');
  }

  /// Prints a divider line for visual separation
  void divider({int length = 50, String symbol = '-'}) {
    developer.log('$_cyanColor${symbol * length}$_resetColor');
  }
}

// Global instance for easy access
final beautifulLogger = ConsoleLogger();
