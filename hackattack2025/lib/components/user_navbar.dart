import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hackattack2025/navigation/route.dart';

class UserNavbar extends StatelessWidget {
  const UserNavbar({super.key});
  final double iconsize = 35.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF078077),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.favouriteindustry,
              ModalRoute.withName(AppRoutes.userhomepage),
            ),
            icon: Icon(
              Icons.favorite_border, // outlined heart
              size: iconsize,
              color: Colors.white,
            )
          ),
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.apiservicepage,
              ModalRoute.withName(AppRoutes.userhomepage),
            ),
            icon: Icon(Icons.build, color: Colors.white, size: iconsize),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.userhomepage,
              ModalRoute.withName(AppRoutes.userhomepage),
            ),
            icon: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  size: iconsize,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.sensorshoplist,
              ModalRoute.withName(AppRoutes.userhomepage),
            ),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              size: iconsize,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.industrychatbot,
              ModalRoute.withName(AppRoutes.userhomepage),
            ),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedBot,
              size: iconsize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
