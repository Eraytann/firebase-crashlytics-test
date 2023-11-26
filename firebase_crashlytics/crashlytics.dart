import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  const fatalError = true;

  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(const CrashlyticsPage());
}

class CrashlyticsPage extends StatefulWidget {
  const CrashlyticsPage({Key? key}) : super(key: key);

  @override
  State<CrashlyticsPage> createState() => _CrashlyticsPageState();
}

class _CrashlyticsPageState extends State<CrashlyticsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crashlytics Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Crashlytics page.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => throw Exception(),
              child: const Text('Throw Test Exception'),
            ),
          ],
        ),
      ),
    );
  }
}
