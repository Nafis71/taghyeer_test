/// Global logger utility for application-wide logging.
///
/// This logger provides a centralized logging solution using the `logger` package.
/// It's configured with pretty printing for better readability during development.
///
/// Features:
/// - Colorful console output for better visibility
/// - Method call stack tracking (3 levels for normal, 5 for errors)
/// - Emoji support for visual distinction
/// - Date and time formatting
/// - Configurable line length
///
/// Usage:
/// ```dart
/// logger.d("Debug message");
/// logger.i("Info message");
/// logger.w("Warning message");
/// logger.e("Error message", stackTrace: stackTrace);
/// ```
///
/// Log levels:
/// - [logger.d]: Debug messages (verbose)
/// - [logger.i]: Info messages (general information)
/// - [logger.w]: Warning messages (potential issues)
/// - [logger.e]: Error messages (exceptions, failures)
import 'package:logger/logger.dart';

/// Global logger instance configured for development and debugging.
///
/// Configured with:
/// - Pretty printer for formatted output
/// - Method count: 3 for normal logs, 5 for errors
/// - Line length: 50 characters
/// - Colors enabled for better readability
/// - Emojis enabled for visual distinction
/// - Date and time formatting enabled
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 3,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
);
