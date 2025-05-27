import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Airsensordata extends StatefulWidget {
  final SensorData sensorData;
  const Airsensordata({super.key, required this.sensorData});

  @override
  State<Airsensordata> createState() => _AirsensordataState();
}

class _AirsensordataState extends State<Airsensordata> {
  final paddingval = 20.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Industryappbar(
              showBackButton: true,
            ),
            Text(widget.sensorData.sensorId),
            Text(widget.sensorData.sensorType),
            Image.asset(
              'assets/images/sensorgraph.png',
              width: 300,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white, // Background for the button area
              child: const SizedBox(
                  width: double.infinity, // Make button full width
                  child: GreenElevatedButton(
                      text: 'Download Full Dataset',
                      navigateTo: AppRoutes.airlocationstats)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}
