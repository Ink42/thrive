





import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:thrive/challenge/view/set_event_view.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: HeatMap(
        defaultColor: Colors.grey.shade600.withOpacity(0.2),
        size: 39,
        showColorTip: false,
  datasets: {
    DateTime(2024, 12, 12): 1,
    DateTime(2024, 12, 13): 2,
    DateTime(2024, 12, 15): 3,
    DateTime(2024, 12, 16): 4,
    DateTime(2024, 12, 17): 5,
  },
  borderRadius: 3,
  margin: EdgeInsets.all(2),
// textColor: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
  textColor: Colors.white,
  

  colorMode: ColorMode.opacity,
  
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 90)),
  showText: true,
  scrollable: true,
  colorsets: {
    1: Colors.amber.shade400,
    2: Colors.amber.shade600,
    3: Colors.amber,
    4: Colors.amber.shade800,
    5: Colors.amber.shade900,
  },
  onClick: (date) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(date.toString())));
    // showAboutDialog(context: context);
    final  value = DateFormat('MMM-dd-yyyy').format(date);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        
        title: Text("Alert!"),
        content: Text("Would you like to set an event on this date ${value}"),
        actions: [
          MaterialButton(
            color: Colors.amber,
            onPressed: ()=>Navigator.popAndPushNamed(context,SetEventView.id) , child: Text("Continue")),
          TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")),
        ],
      );
    });
  },
    )
    );
  }
}