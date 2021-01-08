import 'dart:developer';

void loggerClass(Type tag, String message) {
  log("${tag.runtimeType}: $message");
}

void loggerTag(String tag, String message) {
  log("$tag: $message");
}
