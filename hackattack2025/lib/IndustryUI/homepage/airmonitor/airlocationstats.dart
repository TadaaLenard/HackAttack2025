import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airlocationinfo.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airsensorinfo.dart';

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
  // Note: The Expanded widget is now handled in the build method, not here.
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        // Locationcontent is assumed to be a scrollable or fixed-height widget
        // that doesn't require an Expanded parent itself.
        return const Locationcontent();
      case 1:
        // Sensorscontent is designed to be expanded, so it will fill the space.
        return Sensorscontent(label: widget.label);
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
          // Top section: App Bar, Label, and TabBar. This part has a fixed height
          // or is naturally sized based on its content.
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Industryappbar(showBackButton: true),
                const SizedBox(height: 10),
                Text(
                  widget.label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          // The TappableOptionsBar (TabBar headers)
          TappableOptionsBar(
            tabs: myTabs,
            onTabChanged: (index) {
              setState(() {
                _selectedIndex = index; // Update the selected index
              });
            },
          ),

          Expanded(
            child: _buildTabContent(_selectedIndex),
          ),
          // Fixed button above the navbar
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

    // Add listener to update parent's selected index
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTabChanged(_tabController.index);
      }
    });
  }

  @override
  void didUpdateWidget(covariant TappableOptionsBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      _tabController.dispose();
      _tabController = TabController(length: widget.tabs.length, vsync: this);
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          widget.onTabChanged(_tabController.index);
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
        tabs: widget.tabs,
      ),
    );
  }
}
