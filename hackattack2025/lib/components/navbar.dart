import 'package:flutter/material.dart';
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteIndustryPage(),
                ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApiServicePage(),
                ),
              );
            },
            icon: Icon(
              Icons.build,
              color: Colors.white,
              size: iconsize,
            ),
          ),
          IconButton(
            onPressed: () {},
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
            onPressed: () {},
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              size: iconsize,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          IconButton(
            onPressed: () {},
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
