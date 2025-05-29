import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Addsensor extends StatefulWidget {
  final SensorData? sensorData; // Optional parameter for editing

  const Addsensor({super.key, this.sensorData});

  @override
  State<Addsensor> createState() => _AddsensorState();
}

class _AddsensorState extends State<Addsensor> {
  final paddingval = 20.0;
  final TextEditingController sensoridController = TextEditingController();
  final TextEditingController sensorlocationController =
      TextEditingController();
  final TextEditingController installdateController = TextEditingController();

  String? _selectedSensorType;
  DateTime? _selectedDate;

  final List<String> _sensorTypes = [
    'Particulate Matter ≤2.5 µm (PM2.5)',
    'Heavy Metal Contaminants',
    'pH',
    'Particulate Matter ≤10 µm (PM10)',
    'Sulfur Dioxide (SO2)',
    'Total Organic Carbon (TOC)',
    'Turbidity',
    'Temperature',
    'Humidity',
    'Pressure',
    'Carbon Dioxide (CO2)',
    'Nitrogen Oxides (NOx)',
    'Ozone (O3)',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if sensorData is provided (edit mode)
    if (widget.sensorData != null) {
      sensoridController.text = widget.sensorData!.sensorId;
      sensorlocationController.text = widget.sensorData!.location;
      installdateController.text = widget.sensorData!
          .installationDate!; // Assuming lastReading serves as installation date for pre-fill
      _selectedSensorType = widget.sensorData!.sensorType;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        installdateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    sensoridController.dispose();
    sensorlocationController.dispose();
    installdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          children: [
            const Industryappbar(
              // Moved Industryappbar inside the Column
              showBackButton: true,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: widget.sensorData == null
                  ? const Text(
                      'Add a new Sensor',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Edit Sensor',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(
              height: paddingval,
            ),
            LabeledTextField(
              label: 'Sensor ID',
              placeholder: 'Your sensor ID',
              controller: sensoridController,
            ),
            SizedBox(
              height: paddingval,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sensor Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedSensorType,
                  isExpanded: true, // Added to fix overflow and alignment
                  decoration: InputDecoration(
                    hintText: 'Select Sensor Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: _sensorTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSensorType = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: paddingval,
            ),
            LabeledTextField(
              label: 'Sensor Location',
              placeholder: 'Sensor Location',
              controller: sensorlocationController,
            ),
            SizedBox(
              height: paddingval,
            ),
            DateField(
              label: 'Installation Date',
              placeholder: 'dd/mm/yyyy',
              controller: installdateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            SizedBox(
              height: paddingval,
            ),
            GreenElevatedButton(
              // Added GreenElevatedButton
              text: widget.sensorData != null ? "Update" : "Add",
              navigateTo: AppRoutes.sensorlist,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
      // Removed floatingActionButton and floatingActionButtonLocation
    );
  }
}

class DateField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const DateField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
