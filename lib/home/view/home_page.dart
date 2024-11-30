




import 'package:flutter/material.dart';
import 'package:thrive/home/widgets/build_snap_shot.dart';
import 'package:thrive/home/widgets/expandable_calender.dart';

class HomePage extends StatelessWidget {
  static const String id = "/HomePage";
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
              ExpandableCalender(),
              SizedBox(height: 20,),
            // const _Header(title: "Snapshot", extra: "See Details"),
        buildSnapshotSection(MediaQuery.sizeOf(context))
          ],
        ),
      )
    );
  }
  
  Widget _buildActivityDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        Text(value, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

