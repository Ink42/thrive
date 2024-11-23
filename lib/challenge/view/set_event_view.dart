import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:thrive/const/constant.dart';
import 'package:thrive/global/models/activity_models.dart';

class SetEventView extends StatefulWidget {
  static String id = "/SetEventView";

  const SetEventView({super.key});

  @override
  State<SetEventView> createState() => _SetEventViewState();
}

class _SetEventViewState extends State<SetEventView> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
      ),
      body: SafeArea(
        child: Container(

          padding: EdgeInsets.symmetric(vertical :50,horizontal: 20),
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                maxLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Event Title',
                  icon: Icon(Icons.title_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _summaryController,
                maxLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Event Summary',
                  icon: Icon(Icons.summarize_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select a date"),
                  IconButton(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.calendar_today_rounded),
                  ),
                ],
              ),
              if (selectedDate != null) 
                Text("Selected Date: ${selectedDate?.toLocal().toString().split(' ')[0]}"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select a time"),
                  IconButton(
                    onPressed: () => _selectTime(context),
                    icon: Icon(Icons.watch_later_rounded),
                  ),
                ],
              ),
              if (selectedTime != null) 
                Text("Selected Time: ${selectedTime?.format(context)}"),
              SizedBox(height: 20),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _saveEvent(),
                    child: Text("Save"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _saveEvent() async {
    if (_titleController.text.isEmpty || _summaryController.text.isEmpty || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields must be filled out.")),
      );
      return;
    }

    final dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

   
    final eventData = {
      "title": _titleController.text,
      "summary": _summaryController.text,
      "dateTime": dateTime.toIso8601String(),
    };

    // Save to Hive
    ActivityModels model = ActivityModels(
      "open${dateTime}", 
      "Run", 
      0, 
      0, 
      dateTime, 
      [], 
      _titleController.text , 
      _summaryController.text , 
      false
      );
    final eventBox = Hive.box<ActivityModels>(test_box); // Ensure this box is opened in your main function
    await eventBox.add(model);
    // log("message title ${_titleController.text} summary ${_summaryController.text} and eventdata ${eventData}");
    
    // Clear fields
    _titleController.clear();
    _summaryController.clear();
    selectedDate = null;
    selectedTime = null;
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Event saved successfully!")),
    );

    Navigator.pop(context);
  }
}
