import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
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
    required this.fontSize,
    required this.destinationRoute,
    this.textColor = const Color(0xFF00796B), // default dark green
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, destinationRoute);
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
