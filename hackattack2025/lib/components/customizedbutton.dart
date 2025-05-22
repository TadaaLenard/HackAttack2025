import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hugeicons/hugeicons.dart';

class GreenElevatedButton extends StatelessWidget {
  final String text;
  final String navigateTo;

  const GreenElevatedButton({
    super.key,
    required this.text,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, navigateTo);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 50),
        backgroundColor: const Color(0xFF00796B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}

class WhiteElevatedButton extends StatelessWidget {
  final String text;
  final String navigateTo;

  const WhiteElevatedButton({
    super.key,
    required this.text,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, navigateTo);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 50),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF00796B),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}

class ThirdPartyElevatedButton extends StatelessWidget {
  final String label;

  // Use static const if the map is constant and shared
  static const Map<String, ButtonType> buttonTypeMap = {
    'facebook': ButtonType.facebook,
    'google': ButtonType.google,
    'apple': ButtonType.apple,
  };

  const ThirdPartyElevatedButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSocialButton(
      onTap: () {},
      mini: true,
      buttonType: buttonTypeMap[label] ?? ButtonType.google, // fallback
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final String destinationRoute;
  final Color textColor;

  const CustomTextButton({
    super.key,
    required this.label,
    this.fontSize = 15,
    required this.destinationRoute,
    this.textColor = const Color(0xFF00796B), // default dark green
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          destinationRoute,
          ModalRoute.withName(AppRoutes.roleselection),
        );
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({super.key});

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isChecked ? const Color(0xFF006400) : Colors.transparent,
          border: Border.all(
            color: isChecked ? const Color(0xFF006400) : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: isChecked
            ? const Icon(Icons.check, color: Colors.white)
            : const Icon(Icons.check, color: Color(0xFF006400)),
      ),
    );
  }
}
