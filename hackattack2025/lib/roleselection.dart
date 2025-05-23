import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hugeicons/hugeicons.dart';

class RoleOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const RoleOption({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: 'Select $label role',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            label == 'Normal User'
                ? const HugeIcon(
                    icon: HugeIcons.strokeRoundedUser03,
                    size: 50.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )
                : const HugeIcon(
                    icon: HugeIcons.strokeRoundedFactory02,
                    size: 50.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
            const SizedBox(width: 25),
            Text(
              label,
              style: GoogleFonts.aclonica(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Roleselection extends StatelessWidget {
  const Roleselection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(102, 183, 255, 196)
              ],
              begin: Alignment.topLeft, // Starting point of gradient
              end: Alignment.bottomRight, // Ending point of gradient
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Your Role',
                    style: GoogleFonts.aclonica(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 33),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: RoleOption(
                        label: 'Normal User',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.userentry);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: RoleOption(
                        label: 'Industry',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.userentry);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
