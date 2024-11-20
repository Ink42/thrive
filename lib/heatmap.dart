





import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey,
      child: HeatMap(
        size: 30,
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
  textColor: Colors.white,
  colorMode: ColorMode.opacity,
  
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 100)),
  showText: true,
  scrollable: true,
  colorsets: {
    1: Colors.amber.shade400,
    2: Colors.amber.shade600,
    3: Colors.amber,
    4: Colors.amber.shade800,
    5: Colors.amber.shade900,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
    )
    );
  }
}