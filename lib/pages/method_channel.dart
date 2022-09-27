import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelPage extends StatefulWidget {
  const MethodChannelPage({Key? key}) : super(key: key);

  @override
  State<MethodChannelPage> createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = "Unknown battery level";

  Future<void> _getBatteryLevel() async {
    late String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = "Battery level at $result %.";
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: ${e.message}.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Method Channel"),
       ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text("Get Battery Level")
            ),
            const SizedBox(height: 30),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
