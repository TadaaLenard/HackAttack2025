import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hugeicons/hugeicons.dart';

class Industryhomepage extends StatefulWidget {
  const Industryhomepage({super.key});

  @override
  State<Industryhomepage> createState() => _IndustryhomepageState();
}

class _IndustryhomepageState extends State<Industryhomepage> {
  final paddingval = 20.0;
  final username = "HackAttack 2.0 Sdn Bhd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 255, 241),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(paddingval),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Industryappbar(),
              Text(
                'Hi! $username!',
                style: const TextStyle(fontSize: 17),
              ),
              const Text('Welcome Back!'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: paddingval),
                child: Image.asset(
                  'assets/images/map.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const MonitorOption(
                  navigateTo: AppRoutes.airlocationlist, label: 'Water'),
              SizedBox(height: paddingval),
              const MonitorOption(
                  navigateTo: AppRoutes.airlocationlist, label: 'Air'),
            ],
          ),
        ),
        bottomNavigationBar: const Industrynavbar());
  }
}

class MonitorOption extends StatefulWidget {
  final bool showAlert;
  final String navigateTo;
  final String label;
  final double borderRadius;

  const MonitorOption({
    super.key,
    this.showAlert = true,
    required this.navigateTo,
    required this.label,
    this.borderRadius = 12.0,
  });

  @override
  State<MonitorOption> createState() => _MonitorOptionState();
}

class _MonitorOptionState extends State<MonitorOption> {
  late bool _showAlert;
  final iconsize = 75.0;

  @override
  void initState() {
    super.initState();
    _showAlert = widget.showAlert;
  }

  @override
  void didUpdateWidget(covariant MonitorOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showAlert != widget.showAlert) {
      setState(() {
        _showAlert = widget.showAlert;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFFFAA00), width: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            Navigator.pushNamed(context, widget.navigateTo);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.label} Monitoring',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedAlert01,
                          size: 24.0,
                          color: Color.fromARGB(255, 255, 102, 0),
                        ),
                        SizedBox(width: 10),
                        Text('1 location are in danger!')
                      ],
                    ),
                    const Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedTick01,
                          size: 24.0,
                          color: Color.fromARGB(255, 77, 255, 0),
                        ),
                        SizedBox(width: 10),
                        Text('3 locations are safe')
                      ],
                    ),
                    const Text(
                      'Last update: 18/05/2025 10:30:25',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
                const SizedBox(width: 7),
                widget.label == 'Water'
                    ? HugeIcon(
                        icon: HugeIcons.strokeRoundedWaterPolo,
                        size: iconsize,
                        color: const Color.fromARGB(255, 3, 129, 255),
                      )
                    : HugeIcon(
                        icon: HugeIcons.strokeRoundedFastWind,
                        size: iconsize,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )
              ],
            ),
          ),
        ),
        if (_showAlert)
          Positioned(
            top: -20,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
