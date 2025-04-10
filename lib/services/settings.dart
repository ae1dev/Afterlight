import 'package:afterlight/main.dart';

class SettingsService {
  bool hapticFeedback = true;
  bool backgroundBlack = false;

  void setup() {
    hapticFeedback = box.get('hapticFeedback', defaultValue: true);
    backgroundBlack = box.get('backgroundBlack', defaultValue: false);
  }

  void setHapticFeedback(bool value) {
    hapticFeedback = value;
    box.put('hapticFeedback', value);
  }

  void setBackgroundBlack(bool value) {
    backgroundBlack = value;
    box.put('backgroundBlack', value);
  }
}
