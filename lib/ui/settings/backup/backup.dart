import 'dart:convert';
import 'dart:io';
import 'package:afterlight/main.dart';
import 'package:afterlight/services/apps.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:afterlight/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class BackupView extends ConsumerStatefulWidget {
  const BackupView({super.key});

  @override
  ConsumerState<BackupView> createState() => _BackupViewState();
}

class _BackupViewState extends ConsumerState<BackupView> {
  bool isRestoring = false;

  void createBackup() async {
    try {
      // Get saved data
      Map<String, dynamic> savedData = await settingsService.createBackup();
      String jsonString = jsonEncode(savedData);

      // Get directory
      String? selectedDirectory = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file location',
        fileName: 'afterlight-backup.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: utf8.encode(jsonString),
      );

      // User canceled the picker
      if (selectedDirectory == null) {
        return;
      }

      handleSnackbar('Backup created successfully', context);
    } catch (e) {
      handleSnackbar('Error creating backup', context);
    }
  }

  void restoreBackup() async {
    try {
      // Get directory
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Please select an input file location',
        type: FileType.any,
        // allowedExtensions: ['json', 'JSON'], TODO: Figure out why this is not working correctly
        allowMultiple: false,
      );

      // User canceled the picker
      if (result == null) {
        return;
      }

      setState(() {
        isRestoring = true;
      });

      // Get file
      File file = File(result.files.first.path!);

      // Read file
      String jsonString = await file.readAsString();
      Map<String, dynamic> backup = jsonDecode(jsonString);

      if (backup['app'] == 'Afterlight') {
        await settingsService.restoreBackup(backup);
        await ref.read(appServiceProvider.notifier).init();
        handleSnackbar('Backup restored successfully', context);
      } else {
        handleSnackbar('Invalid backup file', context);
      }
      setState(() {
        isRestoring = false;
      });
    } catch (e) {
      setState(() {
        isRestoring = false;
      });
      handleSnackbar('Error restoring backup', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Backup', style: TextStyle(fontSize: 20)),
                Text(
                  'This will backup your app data to a file on your device.',
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        callHaptic();
                        createBackup();
                      },
                      child: const Text('Backup'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Restore', style: TextStyle(fontSize: 20)),
                Text(
                  'This will restore your app data from a file on your device.',
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    if (isRestoring)
                      Expanded(
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    if (!isRestoring) const Spacer(),
                    const Gap(10),
                    TextButton(
                      onPressed:
                          isRestoring
                              ? null
                              : () {
                                callHaptic();
                                restoreBackup();
                              },
                      child: const Text('Restore'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Gap(35),
        ],
      ),
    );
  }
}
