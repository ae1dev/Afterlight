import 'package:afterlight/main.dart';
import 'package:afterlight/ui/settings/appearance/appearance.dart';
import 'package:afterlight/ui/widgets/icon.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Appearance'),
            trailing: const Icon(Symbols.arrow_forward_rounded),
            onTap: () {
              callHaptic();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppearanceView()),
              );
            },
          ),
          ListTile(
            title: const Text('Haptic Feedback'),
            trailing: Switch(
              value: settingsService.hapticFeedback,
              onChanged: (value) {
                callHaptic();
                settingsService.setHapticFeedback(value);
                setState(() {});
              },
            ),
          ),
          Gap(35),
          Center(child: IconWidget(size: 45)),
        ],
      ),
    );
  }
}
