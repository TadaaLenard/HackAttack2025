import 'package:flutter/material.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hugeicons/hugeicons.dart';

import '../UserUI/favourite_industry.dart';
import '../UserUI/api_service_page.dart';

class Industrynavbar extends StatelessWidget {
  const Industrynavbar({super.key});
  final iconsize = 35.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF078077),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.sensorlist,
                ModalRoute.withName(AppRoutes.industryhomepage),
              );
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedInternetAntenna01,
              size: iconsize,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.schedulelist,
                ModalRoute.withName(AppRoutes.industryhomepage),
              );
            },
            icon: Icon(
              Icons.build,
              color: Colors.white,
              size: iconsize,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.industryhomepage,
                ModalRoute.withName(AppRoutes.industryhomepage),
              );
            },
            icon: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  size: iconsize,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.sensorshoplist,
                ModalRoute.withName(AppRoutes.industryhomepage),
              );
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              size: iconsize,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.industrychatbot,
                ModalRoute.withName(AppRoutes.industryhomepage),
              );
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedBot,
              size: iconsize,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
