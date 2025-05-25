import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Industryappbar extends StatefulWidget {
  final bool showBackButton;

  const Industryappbar({super.key, this.showBackButton = false});

  @override
  State<Industryappbar> createState() => _IndustryappbarState();
}

class _IndustryappbarState extends State<Industryappbar> {
  final iconsize = 40.0;
  final paddingval = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: paddingval),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Logo'),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedNotification03,
                      size: iconsize,
                      color: const Color.fromARGB(255, 54, 90, 0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedUser,
                      size: iconsize,
                      color: const Color.fromARGB(255, 54, 90, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        widget.showBackButton
            ? Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              )
            : const SizedBox.shrink(), // Show nothing if false
      ],
    );
  }
}
