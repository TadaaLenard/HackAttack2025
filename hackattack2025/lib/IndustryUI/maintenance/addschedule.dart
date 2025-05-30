import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Addschedule extends StatefulWidget {
  final ScheduleData? scheduleData; // Optional parameter for editing

  const Addschedule({super.key, this.scheduleData});

  @override
  State<Addschedule> createState() => _AddscheduleState();
}

class _AddscheduleState extends State<Addschedule> {
  final paddingval = 20.0;
  final TextEditingController scheduletypeController = TextEditingController();
  final TextEditingController schedulelocationController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    // Pre-fill fields if scheduleData is provided (edit mode)
    if (widget.scheduleData != null) {
      scheduletypeController.text = widget.scheduleData!.scheduleType;
      schedulelocationController.text = widget.scheduleData!.location;
      dateController.text = widget.scheduleData!.scheduleDate;
      if (widget.scheduleData!.notes != null) {
        notesController.text = widget.scheduleData!.notes!;
      }
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
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    scheduletypeController.dispose();
    schedulelocationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingval),
          child: Column(
            children: [
              const Industryappbar(
                // Moved Industryappbar inside the Column
                showBackButton: true,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: widget.scheduleData == null
                    ? const Text(
                        'Add a new Schedule',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        'Edit Schedule',
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
                label: 'Schedule Title',
                placeholder: 'Your schedule Title',
                controller: scheduletypeController,
              ),
              SizedBox(
                height: paddingval,
              ),
              LabeledTextField(
                label: 'Schedule Location',
                placeholder: 'Schedule Location',
                controller: schedulelocationController,
              ),
              SizedBox(
                height: paddingval,
              ),
              DateField(
                label: 'Maintenance Date',
                placeholder: 'dd/mm/yyyy',
                controller: dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              SizedBox(
                height: paddingval,
              ),
              LabeledTextField(
                label: 'Additional Notes',
                placeholder: 'Optional Notes',
                controller: notesController,
              ),
              SizedBox(
                height: paddingval,
              ),
              GreenElevatedButton(
                // Added GreenElevatedButton
                text: widget.scheduleData != null ? "Edit" : "Add",
                navigateTo: AppRoutes.schedulelist,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
      // Removed floatingActionButton and floatingActionButtonLocation
    );
  }
}
