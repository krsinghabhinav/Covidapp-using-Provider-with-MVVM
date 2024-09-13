import 'dart:convert';
import 'dart:developer'; // For `log` function
import 'package:flutter/foundation.dart'; // For `kDebugMode` and `debugPrint`

void printvalue(dynamic value, {String tag = " "}) {
  try {
    // Attempt to decode the value if it is a valid JSON string
    var decodedJson = jsonDecode(value.toString()) as Map<String, dynamic>;
    log("JSON OUTPUT: $tag ${const JsonEncoder.withIndent('  ').convert(decodedJson)}\n");
  } catch (e) {
    // Handle case where value is not a valid JSON string
    if (value is Map<String, dynamic>) {
      log("JSON OUTPUT: $tag ${const JsonEncoder.withIndent('  ').convert(value)}\n");
    } else {
      // Print the value directly if not in debug mode
      if (kDebugMode) {
        debugPrint("Print Output: $tag $value\n\n");
      }
    }
  }
}
