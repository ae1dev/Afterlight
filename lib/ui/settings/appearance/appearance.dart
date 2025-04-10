import 'package:afterlight/main.dart';
import 'package:afterlight/ui/widgets/icon.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppearanceView extends StatefulWidget {
  const AppearanceView({super.key});

  @override
  State<AppearanceView> createState() => _AppearanceViewState();
}

class _AppearanceViewState extends State<AppearanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Background Black'),
            trailing: Switch(
              value: settingsService.backgroundBlack,
              onChanged: (value) {
                callHaptic();
                settingsService.setBackgroundBlack(value);
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
