import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hugeicons/hugeicons.dart';

class Scheduleinfo extends StatefulWidget {
  final ScheduleData? scheduleData;
  const Scheduleinfo({super.key, this.scheduleData});

  @override
  State<Scheduleinfo> createState() => _ScheduleinfoState();
}

class _ScheduleinfoState extends State<Scheduleinfo> {
  final paddingval = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Industryappbar(
                  showBackButton: true,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.scheduleData!.scheduleType,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedLocation01,
                      size: 24.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.scheduleData!.location,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar03,
                      size: 24.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.scheduleData!.scheduleDate,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Notes:"),
                    const SizedBox(width: 10),
                    widget.scheduleData!.notes != null
                        ? Text(
                            widget.scheduleData!.notes!,
                          )
                        : const Text('No notes available'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            GreenElevatedButton(
              text: "Edit",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addschedule,
                  arguments: widget.scheduleData,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}
