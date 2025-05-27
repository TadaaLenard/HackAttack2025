import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airlocationinfo.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/navigation/route.dart';

class Airlocationstats extends StatefulWidget {
  final String label;
  const Airlocationstats({super.key, required this.label});

  @override
  State<Airlocationstats> createState() => _AirlocationstatsState();
}

class _AirlocationstatsState extends State<Airlocationstats> {
  final double paddingval = 20.0;
  // State to keep track of the currently selected tab index
  int _selectedIndex = 0;

  // Define the content for each tab based on the selected index
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const Locationcontent();
      case 1:
        return const Text('Sensor');
      default:
        return const Center(child: Text('No Content'));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the tabs for the TappableOptionsBar
    const List<Tab> myTabs = [
      Tab(text: 'Location'),
      Tab(text: 'Sensors'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(paddingval),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to start
                      children: [
                        const Industryappbar(showBackButton: true),
                        const SizedBox(height: 10),
                        Text(
                          'Label: ${widget.label}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  // The TappableOptionsBar (now just the TabBar headers)
                  TappableOptionsBar(
                    tabs: myTabs,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedIndex = index; // Update the selected index
                      });
                    },
                  ),
                  // The content area, which changes based on _selectedIndex
                  _buildTabContent(_selectedIndex),
                ],
              ),
            ),
          ),
          // Fixed button above the navbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingval, vertical: 10),
            color: Colors.white, // Background for the button area
            child: const SizedBox(
                width: double.infinity, // Make button full width
                child: GreenElevatedButton(
                    text: 'Download Full Dataset',
                    navigateTo: AppRoutes.airlocationstats)),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

// The TappableOptionsBar widget now only manages the TabBar (headers)
class TappableOptionsBar extends StatefulWidget {
  final List<Tab> tabs;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final ValueChanged<int> onTabChanged; // Callback for parent when tab changes

  const TappableOptionsBar({
    super.key,
    required this.tabs,
    required this.onTabChanged, // Now requires onTabChanged callback
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
  });

  @override
  State<TappableOptionsBar> createState() => _TappableOptionsBarState();
}

class _TappableOptionsBarState extends State<TappableOptionsBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);

    _tabController.addListener(() {
      // Notify the parent about the tab change
      if (!_tabController.indexIsChanging) {
        // Only call when tab selection is final
        widget.onTabChanged(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Removed Column and Expanded/TabBarView
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: widget.indicatorColor ??
            Colors.teal, // Use provided color or default
        labelColor:
            widget.labelColor ?? Colors.teal, // Use provided color or default
        unselectedLabelColor: widget.unselectedLabelColor ??
            Colors.grey, // Use provided color or default
        labelStyle: widget.labelStyle ??
            const TextStyle(
              // Use provided style or default
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            const TextStyle(
              // Use provided style or default
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
        tabs: widget.tabs,
      ),
    );
  }
}
