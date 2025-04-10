import 'package:afterlight/main.dart';
import 'package:gaimon/gaimon.dart';

void callHaptic() {
  if (settingsService.hapticFeedback) {
    Gaimon.light();
  }
}
